// https://discourse.processing.org/t/text-motion-blur-effect/10804/11

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
 
#define PROCESSING_TEXTURE_SHADER
 
uniform sampler2D texture;
 
uniform vec2 texOffset;
uniform vec2 resolution;
 
varying vec4 vertColor;
varying vec4 vertTexCoord;
 
uniform float dx, dy;
uniform int blurSize;       
 
const float pi = 3.14159265;
 
void main() {  
	float xu = gl_FragCoord.x / resolution.x;
	float yu = gl_FragCoord.y / resolution.y;

	float numBlurPixelsPerSide = float(blurSize / 2); 
	float ssigma = blurSize / 4;

	vec2 blurMultiplyVec = vec2(dx, dy);
 
	vec3 incrementalGaussian;
	incrementalGaussian.x = 1.0 / (sqrt(2.0 * pi) * ssigma);
	incrementalGaussian.y = exp(-0.5 / (ssigma * ssigma));
	incrementalGaussian.z = incrementalGaussian.y * incrementalGaussian.y;
 
	vec4 avgValue = vec4(0.0, 0.0, 0.0, 1.0);
	float coefficientSum = 0.0;
 
	avgValue += texture2D(texture, vertTexCoord.st) * incrementalGaussian.x;
	coefficientSum += incrementalGaussian.x;
	incrementalGaussian.xy *= incrementalGaussian.yz;
 
	for (float i = 1.0; i <= numBlurPixelsPerSide; i++) { 
		avgValue += texture2D(texture, vertTexCoord.st - i * texOffset * 
								blurMultiplyVec) * incrementalGaussian.x;         
		avgValue += texture2D(texture, vertTexCoord.st + i * texOffset * 
								blurMultiplyVec) * incrementalGaussian.x;         
		coefficientSum += 2.0 * incrementalGaussian.x;
		incrementalGaussian.xy *= incrementalGaussian.yz;
	}

	gl_FragColor = avgValue / coefficientSum;
}
