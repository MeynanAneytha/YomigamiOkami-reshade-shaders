// Copyright (c) 2009-2015 Gilcher Pascal aka Marty McFly
// Modified by Marot Satil for ReShade 4.0 compatibility and lightly optimized for the GShade project.

uniform int iBloomMixmode <
	ui_type = "combo";
	ui_items = "Linear add\0Screen add\0Screen/Lighten/Opacity\0Lighten\0";
> = 2;
uniform float fBloomThreshold <
	ui_type = "slider";
	ui_min = 0.1; ui_max = 1.0;
	ui_tooltip = "Every pixel brighter than this value triggers bloom.";
> = 0.8;
uniform float fBloomAmount <
	ui_type = "slider";
	ui_min = 0.0; ui_max = 20.0;
	ui_tooltip = "Intensity of bloom.";
> = 0.8;
uniform float fBloomSaturation <
	ui_type = "slider";
	ui_min = 0.0; ui_max = 2.0;
	ui_tooltip = "Bloom saturation. 0.0 means white bloom, 2.0 means very, very colorful bloom.";
> = 0.8;
uniform float3 fBloomTint <
	ui_type = "color";
	ui_tooltip = "R, G and B components of bloom tint the bloom color gets shifted to.";
> = float3(0.7, 0.8, 1.0);

uniform bool bLensdirtEnable <
> = false;
uniform int iLensdirtMixmode <
	ui_type = "combo";
	ui_items = "Linear add\0Screen add\0Screen/Lighten/Opacity\0Lighten\0";
> = 1;
uniform float fLensdirtIntensity <
	ui_type = "slider";
	ui_min = 0.0; ui_max = 2.0;
	ui_tooltip = "Intensity of lensdirt.";
> = 0.4;
uniform float fLensdirtSaturation <
	ui_type = "slider";
	ui_min = 0.0; ui_max = 2.0;
	ui_tooltip = "Color saturation of lensdirt.";
> = 2.0;
uniform float3 fLensdirtTint <
	ui_type = "color";
	ui_tooltip = "R, G and B components of lensdirt tint the lensdirt color gets shifted to.";
> = float3(1.0, 1.0, 1.0);

uniform bool bAnamFlareEnable <
> = false;
uniform float fAnamFlareThreshold <
	ui_type = "slider";
	ui_min = 0.1; ui_max = 1.0;
	ui_tooltip = "Every pixel brighter than this value gets a flare.";
> = 0.9;
uniform float fAnamFlareWideness <
	ui_type = "slider";
	ui_min = 1.0; ui_max = 2.5;
	ui_tooltip = "Horizontal wideness of flare. Don't set too high, otherwise the single samples are visible.";
> = 2.4;
uniform float fAnamFlareAmount <
	ui_type = "slider";
	ui_min = 1.0; ui_max = 20.0;
	ui_tooltip = "Intensity of anamorphic flare.";
> = 14.5;
uniform float fAnamFlareCurve <
	ui_type = "slider";
	ui_min = 1.0; ui_max = 2.0;
	ui_tooltip = "Intensity curve of flare with distance from source.";
> = 1.2;
uniform float3 fAnamFlareColor <
	ui_type = "color";
	ui_tooltip = "R, G and B components of anamorphic flare. Flare is always same color.";
> = float3(0.012, 0.313, 0.588);

uniform bool bLenzEnable <
> = false;
uniform float fLenzIntensity <
	ui_type = "slider";
	ui_min = 0.2; ui_max = 3.0;
	ui_tooltip = "Power of lens flare effect";
> = 1.0;
uniform float fLenzThreshold <
	ui_type = "slider";
	ui_min = 0.6; ui_max = 1.0;
	ui_tooltip = "Minimum brightness an object must have to cast lensflare.";
> = 0.8;

uniform bool bChapFlareEnable <
> = false;
uniform float fChapFlareTreshold <
	ui_type = "slider";
	ui_min = 0.70; ui_max = 0.99;
	ui_tooltip = "Brightness threshold for lensflare generation. Everything brighter than this value gets a flare.";
> = 0.90;
uniform int iChapFlareCount <
	ui_type = "slider";
	ui_min = 1; ui_max = 20;
	ui_tooltip = "Number of single halos to be generated. If set to 0, only the curved halo around is visible.";
> = 15;
uniform float fChapFlareDispersal <
	ui_type = "slider";
	ui_min = 0.25; ui_max = 1.00;
	ui_tooltip = "Distance from screen center (and from themselves) the flares are generated. ";
> = 0.25;
uniform float fChapFlareSize <
	ui_type = "slider";
	ui_min = 0.20; ui_max = 0.80;
	ui_tooltip = "Distance (from screen center) the halo and flares are generated.";
> = 0.45;
uniform float3 fChapFlareCA <
	ui_type = "slider";
	ui_min = -0.5; ui_max = 0.5;
	ui_tooltip = "Offset of RGB components of flares as modifier for Chromatic abberation. Same 3 values means no CA.";
> = float3(0.00, 0.01, 0.02);
uniform float fChapFlareIntensity <
	ui_type = "slider";
	ui_min = 5.0; ui_max = 200.0;
	ui_tooltip = "Intensity of flares and halo, remember that higher threshold lowers intensity, you might play with both values to get desired result.";
> = 100.0;

uniform bool bGodrayEnable <
> = false;
uniform float fGodrayDecay <
	ui_type = "slider";
	ui_min = 0.5000; ui_max = 0.9999;
	ui_tooltip = "How fast they decay. It's logarithmic, 1.0 means infinite long rays which will cover whole screen";
> = 0.9900;
uniform float fGodrayExposure <
	ui_type = "slider";
	ui_min = 0.7; ui_max = 1.5;
	ui_tooltip = "Upscales the godray's brightness";
> = 1.0;
uniform float fGodrayWeight <
	ui_type = "slider";
	ui_min = 0.80; ui_max = 1.70;
	ui_tooltip = "weighting";
> = 1.25;
uniform float fGodrayDensity <
	ui_type = "slider";
	ui_min = 0.2; ui_max = 2.0;
	ui_tooltip = "Density of rays, higher means more and brighter rays";
> = 1.0;
uniform float fGodrayThreshold <
	ui_type = "slider";
	ui_min = 0.6; ui_max = 1.0;
	ui_tooltip = "Minimum brightness an object must have to cast godrays";
> = 0.9;
uniform int iGodraySamples <
	ui_tooltip = "2^x format values; How many samples the godrays get";
> = 128;

uniform float fFlareLuminance <
	ui_type = "slider";
	ui_min = 0.000; ui_max = 1.000;
	ui_tooltip = "bright pass luminance value ";
> = 0.095;
uniform float fFlareBlur <
	ui_type = "slider";
	ui_min = 1.0; ui_max = 10000.0;
	ui_tooltip = "manages the size of the flare";
> = 200.0;
uniform float fFlareIntensity <
	ui_type = "slider";
	ui_min = 0.20; ui_max = 5.00;
	ui_tooltip = "effect intensity";
> = 2.07;
uniform float3 fFlareTint <
	ui_type = "color";
	ui_tooltip = "effect tint RGB";
> = float3(0.137, 0.216, 1.0);

// If 1, only pixels with depth = 1 get lens flares
// This prevents white objects from getting lens flares sources, which would normally happen in LDR
#ifndef LENZ_DEPTH_CHECK
	#define LENZ_DEPTH_CHECK 0
#endif
#ifndef CHAPMAN_DEPTH_CHECK
	#define CHAPMAN_DEPTH_CHECK 0
#endif
#ifndef GODRAY_DEPTH_CHECK
	#define GODRAY_DEPTH_CHECK 0
#endif
#ifndef FLARE_DEPTH_CHECK
	#define FLARE_DEPTH_CHECK 0
#endif

texture texDirt < source = "LensDBA.png"; > { Width = 1920; Height = 1080; Format = RGBA8; };
texture texSprite < source = "LensSprite.png"; > { Width = 1920; Height = 1080; Format = RGBA8; };

sampler SamplerDirt { Texture = texDirt; };
sampler SamplerSprite { Texture = texSprite; };

texture texBloom1
{
	Width = BUFFER_WIDTH;
	Height = BUFFER_HEIGHT;
	Format = RGBA16F;
};
texture texBloom2
{
	Width = BUFFER_WIDTH;
	Height = BUFFER_HEIGHT;
	Format = RGBA16F;
};
texture texBloom3
{
	Width = BUFFER_WIDTH / 2;
	Height = BUFFER_HEIGHT / 2;
	Format = RGBA16F;
};
texture texBloom4
{
	Width = BUFFER_WIDTH / 4;
	Height = BUFFER_HEIGHT / 4;
	Format = RGBA16F;
};
texture texBloom5
{
	Width = BUFFER_WIDTH / 8;
	Height = BUFFER_HEIGHT / 8;
	Format = RGBA16F;
};
texture texLensFlare1
{
	Width = BUFFER_WIDTH / 2;
	Height = BUFFER_HEIGHT / 2;
	Format = RGBA16F;
};
texture texLensFlare2
{
	Width = BUFFER_WIDTH / 2;
	Height = BUFFER_HEIGHT / 2;
	Format = RGBA16F;
};

sampler SamplerBloom1 { Texture = texBloom1; };
sampler SamplerBloom2 { Texture = texBloom2; };
sampler SamplerBloom3 { Texture = texBloom3; };
sampler SamplerBloom4 { Texture = texBloom4; };
sampler SamplerBloom5 { Texture = texBloom5; };
sampler SamplerLensFlare1 { Texture = texLensFlare1; };
sampler SamplerLensFlare2 { Texture = texLensFlare2; };

#include "ReShade.fxh"

#if GSHADE_DITHER
    #include "TriDither.fxh"
#endif

// modified - Craig - Jul 5th, 2020
// !!! re-wrote and re-organized most of it
// !!! see comments in code below
float4 GaussBlur22(float2 coord, sampler tex, float mult, float lodlevel, bool isBlurVert)
{
	const float weight[11] = {
		0.082607,
		0.080977,
		0.076276,
		0.069041,
		0.060049,
		0.050187,
		0.040306,
		0.031105,
		0.023066,
		0.016436,
		0.011254
	};

	float4 sum = 0.0;
	float4 texcoord = float4( coord.xy, 0, lodlevel );

	// !!! loop was doing a lot of wasted calc's mul'ing
	// !!! x or y (the one not changing) by 0 .. so just
	// !!! expanded if/else to only re-calc x or y that
	// !!! is changing. also pre-make texcoord var outside
	// !!! loop so we're not constantly re-creating it inside
	// !!! the loop.
	// !!! lastly, all the func calls to GaussBlur22 use
	// !!! lodlevel = 0, so just do standard tex2D
	// !!! calls and skip the tex2Dlod overhead.
	// !!! going to keep the LOD arg's in just
	// !!! in case someone later on wants to leverage
	// !!! that, but right now it's an unused,
	// !!! over-engineered option.

	if (isBlurVert)
	{
		// vertical axis changing
		float axis = BUFFER_PIXEL_SIZE.y * mult;

		for (int i = -10; i < 11; i++)
		{
			texcoord.y = coord.y + axis * (float)i;
			sum += tex2D(tex, texcoord.xy) * weight[abs(i)];
		}
	}
	else
	{
		// horizontal axis changing
		float axis = BUFFER_PIXEL_SIZE.x * mult;

		for (int i = -10; i < 11; i++)
		{
			texcoord.x = coord.x + axis * (float)i;
			sum += tex2D(tex, texcoord.xy) * weight[abs(i)];
		}

	}

	return sum;
}

float3 GetDnB(sampler tex, float2 coords)
{
#if CHAPMAN_DEPTH_CHECK
	if (tex2Dlod(ReShade::DepthBuffer, float4(coords.xy, 0, 3)).x < 0.99999)
		return 0;
#endif
	return max(0, dot(tex2Dlod(tex, float4(coords.xy, 0, 4)).rgb, 0.333) - fChapFlareTreshold) * fChapFlareIntensity;
}
float3 GetDistortedTex(sampler tex, float2 sample_center, float2 sample_vector, float3 distortion)
{
	const float2 final_vector = sample_center + sample_vector * min(min(distortion.r, distortion.g), distortion.b);

	if (final_vector.x > 1.0 || final_vector.y > 1.0 || final_vector.x < -1.0 || final_vector.y < -1.0)
		return float3(0, 0, 0);
	else
		return float3(
			GetDnB(tex, sample_center + sample_vector * distortion.r).r,
			GetDnB(tex, sample_center + sample_vector * distortion.g).g,
			GetDnB(tex, sample_center + sample_vector * distortion.b).b);
}

float3 GetBrightPass(float2 coords)
{
#if FLARE_DEPTH_CHECK
	const float checkdepth = tex2D(ReShade::DepthBuffer, coords).x;
	if (checkdepth < 0.99999)
		return float3(0.0, 0.0, 0.0);
#endif
	const float3 c = tex2Dlod(ReShade::BackBuffer, float4(coords, 0.0, 0.0)).rgb;

	return lerp(0.0, c, smoothstep(0.0f, 0.5, dot(max(c - fFlareLuminance.xxx, 0.0), 1.0)));
}

float3 GetAnamorphicSample(int axis, float2 coords, float blur)
{
	coords = 2.0 * coords - 1.0;
	coords.x /= -blur;
	return GetBrightPass(0.5 * coords + 0.5);
}

// modified - Craig - Jul 5th, 2020
// !!! re-wrote / re-organized quite a bit
// !!! see notes in code below
void BloomPass0(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 bloom : SV_Target)
{
	// !!! calc once, use twice
	const float2 bps = BUFFER_PIXEL_SIZE * 2;

	// !!! calc (P)ositive & (N)egative offsets once
	const float2 tcP = texcoord + bps;
	const float2 tcN = texcoord - bps;

	// !!! already building out array, so just plug in appropriate
	// !!! pre-calc'ed texcoord values in each element
	const float2 bloomuv[4] = {
		float2( tcP.x, tcP.y),	// texcoord + float2( 1.0, 1.0 ) * BUFFER_PIXEL_SIZE * 2
		float2( tcP.x, tcP.y),	// texcoord + float2( 1.0, 1.0 ) * BUFFER_PIXEL_SIZE * 2
		float2( tcN.x, tcP.y),	// texcoord + float2(-1.0, 1.0 ) * BUFFER_PIXEL_SIZE * 2
		float2( tcN.x, tcN.y)	// texcoord + float2( 1.0,-1.0 ) * BUFFER_PIXEL_SIZE * 2
	};

	// !!! pre-mul const to avoid extra mul's in loop
	float4 tempbloom;
	bloom = 0.0;

	for (int i = 0; i < 4; i++)
	{
		// !!! not using LOD, so use tex2D to skip extra overhead
		// !!! also, generating .w below, so only pull .rgb
		tempbloom.rgb = tex2D(ReShade::BackBuffer, bloomuv[i]).rgb;

		// !!! do max(0, tempbloom) last as single func() call
		tempbloom.w = dot(tempbloom.xyz, 0.333) - fAnamFlareThreshold;
		tempbloom.xyz = tempbloom.xyz - fBloomThreshold;
		bloom += max(0, tempbloom);
	}

	bloom *= 0.25;
}

// modified - Craig - Jul 5th, 2020
// !!! re-wrote / re-organized quite a bit
// !!! see notes in code below
void BloomPass1(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 bloom : SV_Target)
{
	// !!! calc once, use twice
	const float2 bps = BUFFER_PIXEL_SIZE * 4;

	// !!! calc (P)ositive & (N)egative offsets once.
	// !!! we're also using tc as-is, so make a var
	// !!! for it so it just looks cleaner in code below
	// !!! when we build out our offset tc array.
	const float2 tcP = texcoord + bps;
	const float2 tcN = texcoord - bps;
	const float2 tc0 = texcoord;

	// !!! already building out array, so just plug in appropriate
	// !!! pre-calc'ed texcoord values in each element
	const float2 bloomuv[8] = {
		float2(tcP.x, tcP.y),	// texcoord + float2( 1.0, 1.0 ) * BUFFER_PIXEL_SIZE * 4
		float2(tc0.x, tcN.y),	// texcoord + float2( 0.0,-1.0 ) * BUFFER_PIXEL_SIZE * 4
		float2(tcN.x, tcP.y),	// texcoord + float2(-1.0, 1.0 ) * BUFFER_PIXEL_SIZE * 4
		float2(tcN.x, tcN.y),	// texcoord + float2(-1.0,-1.0 ) * BUFFER_PIXEL_SIZE * 4
		float2(tc0.x, tcP.y),	// texcoord + float2( 0.0, 1.0 ) * BUFFER_PIXEL_SIZE * 4
		float2(tc0.x, tcN.y),	// texcoord + float2( 0.0,-1.0 ) * BUFFER_PIXEL_SIZE * 4
		float2(tcP.x, tc0.y),	// texcoord + float2( 1.0, 0.0 ) * BUFFER_PIXEL_SIZE * 4
		float2(tcN.x, tc0.y)	// texcoord + float2(-1.0, 0.0 ) * BUFFER_PIXEL_SIZE * 4
	};

	bloom = 0.0;

	for (int i = 0; i < 8; i++)
	{
		// !!! not using LOD, so use tex2D to skip extra overhead
		bloom += tex2D(SamplerBloom1, bloomuv[i]);
	}

	bloom *= 0.125;
}

// modified - Craig - Jul 5th, 2020
void BloomPass2(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 bloom : SV_Target)
{
	// calc once, use several times
	const float2 bps = BUFFER_PIXEL_SIZE * 8;
	const float2 bps707 = bps * 0.707;

	// !!! calc (P)ositive & (N)egative offsets once.
	// !!! we're doing +/- 0.707 offset on this pass, too
	const float2 tcP1 = texcoord + bps;
	const float2 tcN1 = texcoord - bps;
	const float2 tcP7 = texcoord + bps707;
	const float2 tcN7 = texcoord - bps707;
	const float2 tc00 = texcoord;

	// !!! already building out array, so just plug in appropriate
	// !!! pre-calc'ed texcoord values in each element
	const float2 bloomuv[8] = {
		float2(tcP7.x, tcP7.y),	// texcoord + float2( 0.707, 0.707 ) * BUFFER_PIXEL_SIZE * 8
		float2(tcP7.x, tcN7.y),	// texcoord + float2( 0.707,-0.707 ) * BUFFER_PIXEL_SIZE * 8
		float2(tcN7.x, tcP7.y),	// texcoord + float2(-0.707, 0.707 ) * BUFFER_PIXEL_SIZE * 8
		float2(tcN7.x, tcN7.y),	// texcoord + float2(-0.707,-0.707 ) * BUFFER_PIXEL_SIZE * 8

		float2(tc00.x, tcP1.y),	// texcoord + float2( 0.000, 1.000 ) * BUFFER_PIXEL_SIZE * 8
		float2(tc00.x, tcN1.y),	// texcoord + float2( 0.000,-1.000 ) * BUFFER_PIXEL_SIZE * 8
		float2(tcP1.x, tc00.y),	// texcoord + float2( 1.000, 0.000 ) * BUFFER_PIXEL_SIZE * 8
		float2(tcN1.x, tc00.y)	// texcoord + float2(-1.000, 0.000 ) * BUFFER_PIXEL_SIZE * 8
	};

	bloom = 0.0;

	for (int i = 0; i < 8; i++)
	{
		// !!! not using LOD, so use tex2D to skip extra overhead
		bloom += tex2D(SamplerBloom2, bloomuv[i]);
	}

	bloom *= 0.5; // brighten up the sample, it will lose brightness in H/V Gaussian blur
}

void BloomPass3(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 bloom : SV_Target)
{
	bloom = GaussBlur22(texcoord.xy, SamplerBloom3, 16, 0, 0);
	bloom.w *= fAnamFlareAmount;
	bloom.xyz *= fBloomAmount;
}
void BloomPass4(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 bloom : SV_Target)
{
	bloom.xyz = GaussBlur22(texcoord, SamplerBloom4, 16, 0, 1).xyz * 2.5;	
	bloom.w = GaussBlur22(texcoord, SamplerBloom4, 32 * fAnamFlareWideness, 0, 0).w * 2.5; // to have anamflare texture (bloom.w) avoid vertical blur
}

// modified - Craig - Jul 5th, 2020
void LensFlarePass0(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 lens : SV_Target)
{
	lens = 0;

	// Lenz
	if (bLenzEnable)
	{
		// !!! just cleaning up values to look nicer.
		// !!! also, the .y vals are * 3.5 in loop below,
		// !!! but not going to pre-calc them in case the
		// !!! 3.5 gets changed later
		const float3 lfoffset[19] = {
			float3( 0.90000,  0.01,  4.00),
			float3( 0.70000,  0.25,  25.0),
			float3( 0.30000,  0.25,  15.0),
			float3( 1.00000,  1.00,  5.00),
			float3(-0.15000,  20.0,  1.00),
			float3(-0.30000,  20.0,  1.00),
			float3( 6.00000,  6.00,  6.00),
			float3( 7.00000,  7.00,  7.00),
			float3( 8.00000,  8.00,  8.00),
			float3( 9.00000,  9.00,  9.00),
			float3( 0.24000,  1.00,  10.0),
			float3( 0.32000,  1.00,  10.0),
			float3( 0.40000,  1.00,  10.0),
			float3( 0.50000, -0.50,  2.00),
			float3( 2.00000,  2.00, -5.00),
			float3(-5.00000,  0.20,  0.20),
			float3( 20.0000,  0.50,  0.00),
			float3( 0.40000,  1.00,  10.0),
			float3( 0.00001,  10.0,  20.0)
		};

		// !!! just cleaning up values to look nicer
		const float3 lffactors[19] = {
			float3(1.500, 1.500, 0.000),
			float3(0.000, 1.500, 0.000),
			float3(0.000, 0.000, 1.500),
			float3(0.200, 0.250, 0.000),
			float3(0.150, 0.000, 0.000),
			float3(0.000, 0.000, 0.150),
			float3(1.400, 0.000, 0.000),
			float3(1.000, 1.000, 0.000),
			float3(0.000, 1.000, 0.000),
			float3(0.000, 0.000, 1.400),
			float3(1.000, 0.300, 0.000),
			float3(1.000, 1.000, 0.000),
			float3(0.000, 2.000, 4.000),
			float3(0.200, 0.100, 0.000),
			float3(0.000, 0.000, 1.000),
			float3(1.000, 1.000, 0.000),
			float3(1.000, 1.000, 0.000),
			float3(0.000, 0.000, 0.200),
			float3(0.012, 0.313, 0.588)
		};

		float2 lfcoord = 0;
		float3 lenstemp = 0;
		const float2 distfact = float2((texcoord.x - 0.5) * BUFFER_ASPECT_RATIO, texcoord.y - 0.5);

		// !!! pre-calc this to avoid doing length() over and over in loop
		const float distfactlen = 2.0 * length(distfact);

		for (int i = 0; i < 19; i++)
		{
			lfcoord.xy = lfoffset[i].x * distfact;
			lfcoord.xy *= pow(distfactlen, lfoffset[i].y * 3.5);
			lfcoord.xy *= lfoffset[i].z;
			lfcoord.xy = 0.5 - lfcoord.xy;
			float2 tempfact = (lfcoord.xy - 0.5) * 2;

			float lenstemp1;
#if LENZ_DEPTH_CHECK
			float templensdepth = tex2D(ReShade::DepthBuffer, lfcoord.xy).x;
			if (templensdepth < 0.99999)
				lenstemp1 = 0;
			else
#endif
			// !!! making this float instead of float3
			// !!! to cut down on unnecessary calculations
				lenstemp1 = dot(tex2Dlod(ReShade::BackBuffer, float4(lfcoord.xy, 0, 1)).rgb, 0.333);

			// !!! with it float, we can just do float - float
			// !!! and then have lffactors (float3) * ( float * float )
			// !!! replaced clamp(x,0,1) with saturate(x) just to be consistent in func usage
			lenstemp1 = max(0.0, lenstemp1 - fLenzThreshold) + lffactors[i].x * (lenstemp1 * saturate(1.0 - dot(tempfact, tempfact)));
		}

		lens.rgb += lenstemp * fLenzIntensity;
	}

	// Chapman Lens
	if (bChapFlareEnable)
	{
		const float2 sample_vector = (float2(0.5, 0.5) - texcoord.xy) * fChapFlareDispersal;
		const float2 halo_vector = normalize(sample_vector) * fChapFlareSize;

		float3 chaplens = GetDistortedTex(ReShade::BackBuffer, texcoord.xy + halo_vector, halo_vector, fChapFlareCA * 2.5f).rgb;

		for (int j = 0; j < iChapFlareCount; ++j)
		{
			float2 foffset = sample_vector * float(j);
			chaplens += GetDistortedTex(ReShade::BackBuffer, texcoord.xy + foffset, foffset, fChapFlareCA).rgb;
		}

		// !!! chaplens mul by 1 = chaplens, so skip mul'ing by 1 and just divide by iChapFlareCount
		chaplens /= iChapFlareCount;
		lens.xyz += chaplens;
	}

	// Godrays
	if (bGodrayEnable)
	{
		const float2 ScreenLightPos = float2(0.5, 0.5);

		// !!! mul'ing by 1 can get skipped.. just divide

		// !!! all of this can get moved out of loop below,
		// !!! b/c not impacted by g++ iterator

		const float2 texcoord2 = texcoord - ((texcoord - ScreenLightPos) / ((float)iGodraySamples * fGodrayDensity));

		// !!! not using LOD, so use tex2D to save processing
		// !!! also we're calculating .w, so just pull .rgb
		const float sampledepth = tex2D(ReShade::DepthBuffer, texcoord2).x;
		float4 sample2;
		sample2.rgb = tex2Dlod(ReShade::BackBuffer, float4(texcoord2, 0.0, 0.0)).rgb;
		sample2.w = saturate(dot(sample2.xyz, 0.3333) - fGodrayThreshold);

		// !!! mul'ing sample2.r by 1, skip
		sample2.g *= 0.95;
		sample2.b *= 0.85;

		float illuminationDecay = 1.0;
			
		for (int g = 0; g < iGodraySamples; g++)
		{
			// !!! make copy of sample2 to modify
			// !!! float4 * ( float * float )
			float4 sample2copy = sample2 * (illuminationDecay * fGodrayWeight);
			
#if GODRAY_DEPTH_CHECK == 1
			if (sampledepth > 0.99999)
#endif
				lens.rgb += sample2copy.xyz * sample2copy.w;

			illuminationDecay *= fGodrayDecay;
		}
	}

	// Anamorphic flare
	if (bAnamFlareEnable)
	{
		const float gaussweight[5] = { 0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 0.0162162162 };

		// !!! can pre-calc brh outside loop
		const float brh = BUFFER_RCP_HEIGHT * 2;
		float2 anamCoord = texcoord.xy;
		float3 anamSample;
		float3 anamFlare = 0;

		for (int z = -4; z < 5; z++)
		{
//			anamFlare += GetAnamorphicSample(0, texcoord.xy + float2(0, z * brh), fFlareBlur) * fFlareTint * gaussweight[abs(z)];

			// !!! we're only adjusting .y, so skip modifying .x
			anamCoord.y = texcoord.y + z * brh;
			anamSample = GetAnamorphicSample(0, anamCoord, fFlareBlur);
			anamFlare += anamSample * fFlareTint * gaussweight[abs(z)];
		}

		lens.xyz += anamFlare * fFlareIntensity;
	}
}

void LensFlarePass1(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 lens : SV_Target)
{
	lens = GaussBlur22(texcoord, SamplerLensFlare1, 2, 0, 1);
}
void LensFlarePass2(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 lens : SV_Target)
{
	lens = GaussBlur22(texcoord, SamplerLensFlare2, 2, 0, 0);
}

// modified - Craig - Jul 5th, 2020
void LightingCombine(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 color : SV_Target)
{
	color = tex2D(ReShade::BackBuffer, texcoord);
	
	// !!! mul'ing by 1 can get skipped
	float3 colorbloom = saturate((tex2D(SamplerBloom3, texcoord).rgb + (tex2D(SamplerBloom5, texcoord).rgb * 9.0)) * 0.1);// * 1.0;
	colorbloom = lerp(dot(colorbloom, 0.333), colorbloom, fBloomSaturation) * fBloomTint;

	switch (iBloomMixmode)
	{
		case 0:
			color.rgb += colorbloom;
			break;
		case 1:
			color.rgb = 1 - (1 - color.rgb) * (1 - colorbloom);			
			break;
		case 2:
			// !!! get rid of redundant calc's
			colorbloom = 1 - saturate(colorbloom);
			colorbloom = 1 - ( colorbloom * colorbloom );
			// !!! lerp (x, y, 1) returns y w/o any x interpolated in it, so we can skip the lerp
			color.rgb = max(0.0f, max(color.rgb, colorbloom.rgb));
			break;
		case 3:
			color.rgb = max(color.rgb, colorbloom.rgb);
			break;
	}

	// Anamorphic flare
	if (bAnamFlareEnable)
	{
		// !!! force floats to mul first before mul'ing with float3
		color.rgb += pow(max((tex2D(SamplerBloom5, texcoord.xy).w * 2) * fAnamFlareColor, 0.0), 1.0 / fAnamFlareCurve);
	}

	// Lens dirt
	if (bLensdirtEnable)
	{
		// !!! float3 * ( float * float )
		float3 lensdirt = tex2D(SamplerDirt, texcoord).rgb * (dot(tex2D(SamplerBloom5, texcoord).rgb, 0.333) * fLensdirtIntensity);

		lensdirt = lerp(dot(lensdirt.xyz, 0.333), lensdirt.xyz, fLensdirtSaturation);

		switch (iLensdirtMixmode)
		{
			case 0:
				color.rgb += lensdirt;
				break;
			case 1:
				color.rgb = 1 - (1 - color.rgb) * (1 - lensdirt);				
				break;
			case 2:
				// !!! pre-calc redundant calculations
				lensdirt = 1 - saturate(lensdirt);
				lensdirt = 1 - ( lensdirt * lensdirt );
				// !!! lerp(x, y, 1) returns all of y and no x interpolated in, so skip the lerp and just use y
				color.rgb = max(0.0f, max(color.rgb, lensdirt));
				break;
			case 3:
				color.rgb = max(color.rgb, lensdirt);
				break;
		}
	}

	// Lens flares
	if (bAnamFlareEnable || bLenzEnable || bGodrayEnable || bChapFlareEnable)
	{
		float3 lensflareSample = tex2D(SamplerLensFlare1, texcoord.xy).rgb, lensflareMask;

		// !!! pre-calc the texcoord stuff once
		// !!! and get rid of redundant math.
		// !!! Jul 7th 2020 .. modified changes
		// !!! after realizing BUFFER_PIXEL_SIZE is float2
		// !!! (P)ositive, (N)egative
		float2 bpsPP = BUFFER_PIXEL_SIZE * 0.5;
		float2 bpsNN = -bpsPP + texcoord; // can just invert this
		
		// !!! now we can add texcoord to the pos
		bpsPP += texcoord;

		// !!! then just generate the NP & PN with the
		// !!! pre-calc'ed values from PP & NN		
		lensflareMask  = tex2D(SamplerSprite, bpsPP).rgb;
		lensflareMask += tex2D(SamplerSprite, float2(bpsNN.x, bpsPP.y)).rgb;
		lensflareMask += tex2D(SamplerSprite, float2(bpsPP.x, bpsNN.y)).rgb;
		lensflareMask += tex2D(SamplerSprite, bpsNN).rgb;

		color.rgb += lensflareMask * 0.25 * lensflareSample;
	}
#if GSHADE_DITHER
		color.rgb += TriDither(color.rgb, texcoord, BUFFER_COLOR_BIT_DEPTH);
#endif
}

technique BloomAndLensFlares
{
	pass BloomPass0
	{
		VertexShader = PostProcessVS;
		PixelShader = BloomPass0;
		RenderTarget = texBloom1;
	}
	pass BloomPass1
	{
		VertexShader = PostProcessVS;
		PixelShader = BloomPass1;
		RenderTarget = texBloom2;
	}
	pass BloomPass2
	{
		VertexShader = PostProcessVS;
		PixelShader = BloomPass2;
		RenderTarget = texBloom3;
	}
	pass BloomPass3
	{
		VertexShader = PostProcessVS;
		PixelShader = BloomPass3;
		RenderTarget = texBloom4;
	}
	pass BloomPass4
	{
		VertexShader = PostProcessVS;
		PixelShader = BloomPass4;
		RenderTarget = texBloom5;
	}

	pass LensFlarePass0
	{
		VertexShader = PostProcessVS;
		PixelShader = LensFlarePass0;
		RenderTarget = texLensFlare1;
	}
	pass LensFlarePass1
	{
		VertexShader = PostProcessVS;
		PixelShader = LensFlarePass1;
		RenderTarget = texLensFlare2;
	}
	pass LensFlarePass2
	{
		VertexShader = PostProcessVS;
		PixelShader = LensFlarePass2;
		RenderTarget = texLensFlare1;
	}

	pass LightingCombine
	{
		VertexShader = PostProcessVS;
		PixelShader = LightingCombine;
	}
}
