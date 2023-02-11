/** Color conversion matrix and blue noise dither library, version 1.3.2

This code © 2022 Jakub Maksymilian Fober

This work is licensed under the Creative Commons
Attribution 3.0 Unported License.
To view a copy of this license, visit
http://creativecommons.org/licenses/by/3.0/.
*/

	/* MACROS */

#pragma once
// Change this, if you load bigger texture
#define DITHER_SIZE_TEX 64u
#if BUFFER_COLOR_SPACE < 2 // 8-bit quantization
	#define QUANTIZATION_LEVEL 255
#else // 10-bit quantization
	#define QUANTIZATION_LEVEL 1023
#endif

	/* CONSTANTS */

/* Get color conversion matrix
   Usage:
   First define ITU_REC:

   #ifndef ITU_REC
   	#define ITU_REC 601
   #endif

   Then use following functions in code:

   mul( YCbCrMtx, color.rgb) will give you float3 color in YCbCr from sRGB input.
   mul(   RgbMtx, color.xyz) will give you float3 color in sRGB from YCbCr input.
   mul(ChromaMtx, color.rgb) will give you float2 chroma component of YCbCr from sRGB color input.
   dot(  LumaMtx, color.rgb) will give you float luma component of YCbCr from sRGB color input. */
#ifdef ITU_REC
	// YCbCr coefficients
	#if ITU_REC==601
		#define KR 0.299
		#define KB 0.114
	#elif ITU_REC==709
		#define KR 0.2126
		#define KB 0.0722
	#elif ITU_REC==2020
		#define KR 0.2627
		#define KB 0.0593
	#endif
	// ...more in the future

	// RGB to YCbCr matrix
	static const float3x3 YCbCrMtx =
		float3x3(
			float3(KR, 1f-KR-KB, KB), // Luma (Y)
			float3(-0.5*KR/(1f-KB), -0.5*(1f-KR-KB)/(1f-KB), 0.5), // Chroma (Cb)
			float3(0.5, -0.5*(1f-KR-KB)/(1f-KR), -0.5*KB/(1f-KR))  // Chroma (Cr)
		);
	// RGB to YCbCr-luma matrix
	static const float3 LumaMtx = float3(KR, 1f-KR-KB, KB); // Luma (Y)
	// RGB to YCbCr-chroma matrix
	static const float3x2 ChromaMtx =
		float3x2(
			float3(-0.5*KR/(1f-KB), -0.5*(1f-KR-KB)/(1f-KB), 0.5), // Chroma (Cb)
			float3(0.5, -0.5*(1f-KR-KB)/(1f-KR), -0.5*KB/(1f-KR))  // Chroma (Cr)
		);
	// YCbCr to RGB matrix
	static const float3x3 RgbMtx =
		float3x3(
			float3(1f, 0f, 2f-2f*KR), // Red
			float3(1f, -KB/(1f-KR-KB)*(2f-2f*KB), -KR/(1f-KR-KB)*(2f-2f*KR)), // Green
			float3(1f, 2f-2f*KB, 0f) // Blue
		);
#endif

	/* FUNCTIONS */

// Convert display gamma for all vector types (approximate)
#define TO_DISPLAY_GAMMA(g) pow(abs(g), rcp(2.2))
#define TO_LINEAR_GAMMA(g) pow(abs(g), 2.2)
// Function version linear ↦ sRGB (simplified)
float  to_display_gamma(float  g) { return TO_DISPLAY_GAMMA(g); }
float2 to_display_gamma(float2 g) { return TO_DISPLAY_GAMMA(g); }
float3 to_display_gamma(float3 g) { return TO_DISPLAY_GAMMA(g); }
float4 to_display_gamma(float4 g) { return TO_DISPLAY_GAMMA(g); }
// Function version sRGB ↦ linear (simplified)
float  to_linear_gamma(float  g) { return TO_LINEAR_GAMMA(g); }
float2 to_linear_gamma(float2 g) { return TO_LINEAR_GAMMA(g); }
float3 to_linear_gamma(float3 g) { return TO_LINEAR_GAMMA(g); }
float4 to_linear_gamma(float4 g) { return TO_LINEAR_GAMMA(g); }
/* Convert display gamma for all vector types (sRGB)
   Sourced from International Color Consortium, at:
   https://color.org/chardata/rgb/srgb.xalter */
#define TO_DISPLAY_GAMMA_HQ(g) ((g)<=0.0031308? (g)*12.92 : pow(abs(g), rcp(2.4))*1.055-0.055)
#define TO_LINEAR_GAMMA_HQ(g) ((g)<=0.04049936? (g)/12.92 : pow((abs(g)+0.055)/1.055, 2.4))
// Function version linear ↦ sRGB
float  to_display_gamma_hq(float  g) { return TO_DISPLAY_GAMMA_HQ(g); }
float2 to_display_gamma_hq(float2 g) { return TO_DISPLAY_GAMMA_HQ(g); }
float3 to_display_gamma_hq(float3 g) { return TO_DISPLAY_GAMMA_HQ(g); }
float4 to_display_gamma_hq(float4 g) { return TO_DISPLAY_GAMMA_HQ(g); }
// Function version sRGB ↦ linear
float  to_linear_gamma_hq(float  g) { return TO_LINEAR_GAMMA_HQ(g); }
float2 to_linear_gamma_hq(float2 g) { return TO_LINEAR_GAMMA_HQ(g); }
float3 to_linear_gamma_hq(float3 g) { return TO_LINEAR_GAMMA_HQ(g); }
float4 to_linear_gamma_hq(float4 g) { return TO_LINEAR_GAMMA_HQ(g); }

// Dither
namespace BlueNoise
{
	/* The blue noise texture
	   Obtained under CC0, from:
	   https://momentsingraphics.de/BlueNoise.html */
	texture BlueNoiseTex
	<
		source = "fubax_bluenoise.png";
		pooled = true;
	>{
		Width = DITHER_SIZE_TEX;
		Height = DITHER_SIZE_TEX;
		Format = RGBA8;
	};
	// Sampler for blue noise texture
	sampler BlueNoiseTexSmp
	{
		Texture = BlueNoiseTex;
		// Repeat texture coordinates
		AddressU = REPEAT;
		AddressV = REPEAT;
	};

	/* Dither functions
	   Usage:
	   Transform final color by this function, at the very end of a pixel shader:
	   	return BlueNoise::dither(uint2(pos.xy), color);
	   where "pos.xy" is a variable mapped to
	   SV_Position input from a pixel shader. */
	float dither(int2 pixelPos, float gradient)
	{
		// Scale to quantization range
		gradient *= QUANTIZATION_LEVEL;
		// Get blue noise repeated texture
		float noise = tex2Dfetch(BlueNoiseTexSmp, pixelPos%DITHER_SIZE_TEX).r;
		// Dither quantization
		gradient = frac(gradient) >= noise? ceil(gradient) : floor(gradient);
		// Normalize
		return gradient/QUANTIZATION_LEVEL;
	}
	float3 dither(int2 pixelPos, float3 color)
	{
		// Scale to quantization range
		color *= QUANTIZATION_LEVEL;
		// Get blue noise repeated texture
		float3 noise = tex2Dfetch(BlueNoiseTexSmp, pixelPos%DITHER_SIZE_TEX).rgb;
		// Get threshold for noise amount
		float3 slope = frac(color);
		// Dither quantization
		[unroll]
		for (uint i=0u; i<3u; i++)
			color[i] = slope[i] >= noise[i]? ceil(color[i]) : floor(color[i]);
		// Normalize
		return color/QUANTIZATION_LEVEL;
	}
	float4 dither(int2 pixelPos, float4 color)
	{
		// Scale to quantization range
		color *= QUANTIZATION_LEVEL;
		// Get blue noise repeated texture
		float4 noise = tex2Dfetch(BlueNoiseTexSmp, pixelPos%DITHER_SIZE_TEX);
		// Get threshold for noise amount
		float4 slope = frac(color);
		// Dither quantization
		[unroll]
		for (uint i=0u; i<4u; i++)
			color[i] = slope[i] >= noise[i]? ceil(color[i]) : floor(color[i]);
		// Normalize
		return color/QUANTIZATION_LEVEL;
	}
}