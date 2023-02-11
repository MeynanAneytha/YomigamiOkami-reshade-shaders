/** Filmic Sharpen PS, version 1.4.1

This code © 2018 Jakub Maximilian Fober

This work is licensed under the Creative Commons
Attribution-ShareAlike 4.0 International License.
To view a copy of this license, visit
http://creativecommons.org/licenses/by-sa/4.0/.

Please add the name of the shader used and a link to ReShade website
https://reshade.me, to any derivative work shared online.

For updates visit GitHub repository at
https://github.com/Fubaxiusz/fubax-shaders

If you want to use this shader code in your commercial game/project,
contact me at
jakub.m.fober@protonmail.com
*/

	/* MACROS */

#ifndef ITU_REC
	#define ITU_REC 601
#endif

	/* COMMONS */

#include "ReShade.fxh"
#include "ColorAndDither.fxh"

	/* MENU */

uniform uint Strength <
	ui_type = "slider";
	ui_label = "Strength";
	ui_min = 1u; ui_max = 64u;
> = 32u;

uniform float Offset <
	ui_type = "slider";
	ui_label = "Radius";
	ui_tooltip = "High-pass cross offset in pixels";
	ui_min = 0.05; ui_max = 0.25; ui_step = 0.01;
> = 0.1;

uniform bool UseMask <
	ui_type = "input";
	ui_label = "Sharpen only center";
	ui_tooltip = "Sharpen only in center of the image";
> = false;

uniform float Clamp <
	ui_type = "slider";
	ui_label = "Clamping highlights";
	ui_min = 0.5; ui_max = 1.0; ui_step = 0.1;
	ui_category = "Additional settings";
	ui_category_closed = true;
> = 0.6;

uniform bool Preview <
	ui_type = "input";
	ui_label = "Preview sharpen layer";
	ui_tooltip = "Preview sharpen layer and mask for adjustment.\n"
		"If you don't see red strokes,\n"
		"try changing Preprocessor Definitions in the Settings tab.";
	ui_category = "Debug View";
	ui_category_closed = true;
> = false;

	/* FUNCTIONS */

// Overlay blending mode
float Overlay(float LayerA, float LayerB)
{
	float MinA = min(LayerA, 0.5);
	float MinB = min(LayerB, 0.5);
	float MaxA = max(LayerA, 0.5);
	float MaxB = max(LayerB, 0.5);
	return 2f*((MinA*MinB+MaxA)+(MaxB-MaxA*MaxB))-1.5;
}

	/* SHADER */

// Sharpen pass
void FilmicSharpenPS(float4 pixelPos : SV_Position, float2 UvCoord : TEXCOORD, out float3 color : SV_Target)
{
	// Sample display image
	color = tex2D(ReShade::BackBuffer, UvCoord).rgb;

	// Generate and apply radial mask
	float Mask;
	if (UseMask)
	{
		// Center coordinates
		float2 viewCoord = UvCoord*2f-1f;
		// Correct aspect
		viewCoord.y *= BUFFER_HEIGHT*BUFFER_RCP_WIDTH;
		// Generate radial mask
		Mask = Strength-min(dot(viewCoord, viewCoord), 1f)*Strength;
	}
	else Mask = Strength;

	// Get pixel size
	float2 Pixel = BUFFER_PIXEL_SIZE*Offset;

	// Sampling coordinates
	float2 NorSouWesEst[4] = {
		float2(UvCoord.x, UvCoord.y+Pixel.y),
		float2(UvCoord.x, UvCoord.y-Pixel.y),
		float2(UvCoord.x+Pixel.x, UvCoord.y),
		float2(UvCoord.x-Pixel.x, UvCoord.y)
	};

	// Luma high-pass
	float HighPass = 0f;
	[unroll]
	for(uint i=0u; i<4u; i++)
		HighPass += dot(LumaMtx, tex2D(ReShade::BackBuffer, NorSouWesEst[i]).rgb);

	HighPass = 0.5-0.5*(HighPass*0.25-dot(LumaMtx, color));

	// Sharpen strength
	HighPass = lerp(0.5, HighPass, Mask);

	// Clamp sharpening
	HighPass = Clamp!=1f? clamp(HighPass, 1f-Clamp, Clamp) : HighPass;

	// Choose output
	if (Preview) color = HighPass;
	else
	{
		[unroll]
		for(uint i=0u; i<3u; i++)
			// Apply sharpening
			color[i] = Overlay(color[i], HighPass);
	}

	// Dither final 8/10-bit result
	color = BlueNoise::dither(uint2(pixelPos.xy), color);
}

	/* OUTPUT */

technique FilmicSharpen < ui_label = "Filmic Sharpen"; >
{
	pass
	{
		VertexShader = PostProcessVS;
		PixelShader = FilmicSharpenPS;
	}
}
