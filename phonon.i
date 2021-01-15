%module phonon
%{
  /* Includes the header in the wrapper code */
#include "phonon.h"
#include "phonon_version.h"
#define true 1
#define false 0
%}

%include "enums.swg"
%include "arrays_java.i"
%include "cpointer.i"
%javaconst(1);

%apply bool { enum IPLbool };
%pointer_functions(void *, IPLHandle);

%typemap(jni) int * "jobject"
%typemap(jtype) int * "java.nio.IntBuffer"
%typemap(jstype) int * "java.nio.IntBuffer"
%typemap(javain,
  pre="  assert $javainput.isDirect() : \"Buffer must be allocated direct.\";") int * "$javainput"
%typemap(javaout) int * {
  return $jnicall;
}
%typemap(in) int * {
  $1 = (int *) JCALL1(GetDirectBufferAddress, jenv, $input);
  if ($1 == NULL) {
    SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, "Unable to get address of a java.nio.IntBuffer direct byte buffer. Buffer must be a direct buffer and not a non-direct buffer.");
  }
}
%typemap(memberin) int * {
  if ($input) {
    $1 = $input;
  } else {
    $1 = 0;
  }
}
%typemap(freearg) int * ""

%typemap(jni) float * "jobject"
%typemap(jtype) float * "java.nio.FloatBuffer"
%typemap(jstype) float * "java.nio.FloatBuffer"
%typemap(javain,
  pre="  assert $javainput.isDirect() : \"Buffer must be allocated direct.\";") float * "$javainput"
%typemap(javaout) float * {
  return $jnicall;
}
%typemap(in) float * {
  $1 = (float *) JCALL1(GetDirectBufferAddress, jenv, $input);
  if ($1 == NULL) {
    SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, "Unable to get address of a java.nio.FloatBuffer direct byte buffer. Buffer must be a direct buffer and not a non-direct buffer.");
  }
}
%typemap(memberin) float * {
  if ($input) {
    $1 = $input;
  } else {
    $1 = 0;
  }
}
%typemap(freearg) float * ""

/*
%extend IPLVector3 {
  IPLVector3(int x, int y, int z) {
    $this->x = x;
    $this->y = y;
    $this->z = z;
  }
}

%extend IPLBox {
  IPLBox(IPLVector3 minCoords, IPLVector3 maxCoords) {
    $this->minCoordinates = minCoords;
    $this->maxCoordinates = maxCoords;
  }
}

%extend IPLSphere {
  IPLSphere(IPLVector3 center, IPLfloat32 radius) {
    $this->center = center;
    $this->radius = radius;
  }
}

%extend IPLComputeDeviceFilter {
  IPLComputeDeviceFilter(IPLComputeDeviceType type, IPLint32 maxCUsToReserve, IPLfloat32 fractionCUsForIRUpdate) {
    $this->type = type;
    $this->maxCUsToReserve = maxCUsToReserve;
    $this->fractionCUsForIRUpdate = fractionCUsForIRUpdate;
  }
}

%extend IPLSimulationSettings {
  IPLSimulationSettings(
      IPLSceneType sceneType,
      IPLint32 maxNumOcclusionSamples,
      IPLint32            numRays,
      IPLint32            numDiffuseSamples,
      IPLint32            numBounces,
      IPLint32            numThreads,
      IPLfloat32          irDuration,
      IPLint32            ambisonicsOrder,
      IPLint32            maxConvolutionSources,
      IPLint32            bakingBatchSize,
      IPLfloat32          irradianceMinDistance
      ) {
    this->sceneType = sceneType;
    this->maxNumOcclusionSamples = maxNumOcclusionSamples;
    this->numRays = numRays;
    this->numDiffuseSamples = numDiffuseSamples;
    this->numBounces = numBounces;
    this->numThreads = numThreads;
    this->irDuration = irDuration;
    this->ambisonicsOrder = ambisonicsOrder;
    this->maxConvolutionSources = maxConvolutionSources;
    this->bakingBatchSize = bakingBatchSize;
    this->irradianceMinDistance = irradianceMinDistance;
  }
}

%extend IPLSimulationSettings {
  IPLSimulationSettings(
      IPLSceneType sceneType,
      IPLint32 maxNumOcclusionSamples,
      IPLint32            numRays,
      IPLint32            numDiffuseSamples,
      IPLint32            numBounces,
      IPLint32            numThreads,
      IPLfloat32          irDuration,
      IPLint32            ambisonicsOrder,
      IPLint32            maxConvolutionSources,
      IPLfloat32          irradianceMinDistance
      ) {
    this->sceneType = sceneType;
    this->maxNumOcclusionSamples = maxNumOcclusionSamples;
    this->numRays = numRays;
    this->numDiffuseSamples = numDiffuseSamples;
    this->numBounces = numBounces;
    this->numThreads = numThreads;
    this->irDuration = irDuration;
    this->ambisonicsOrder = ambisonicsOrder;
    this->maxConvolutionSources = maxConvolutionSources;
    this->irradianceMinDistance = irradianceMinDistance;
  }
}

%extend IPLTriangle {
  IPLTriangle(IPLint32 indices[]) {
    this->indices = indices;
  }
}

%extend IPLMaterial {
  IPLMaterial(
      IPLfloat32 lowFreqAbsorption,
      IPLfloat32 midFreqAbsorption,
      IPLfloat32 highFreqAbsorption,
      IPLfloat32 scattering,
      IPLfloat32 lowFreqTransmission,
      IPLfloat32 midFreqTransmission,
      IPLfloat32 highFreqTransmission
      ) {
    this->lowFreqAbsorption = lowFreqAbsorption;
    this->midFreqAbsorption = midFreqAbsorption;
    this->highFreqAbsorption = highFreqAbsorption;
    this->scattering = scattering;
    this->lowFreqTransmission = lowFreqTransmission;
    this->midFreqTransmission = midFreqTransmission;
    this->highFreqTransmission = highFreqTransmission;
  }
}

%extend IPLMatrix4x4 {
  IPLMatrix4x4(float elements[][]) {
    this->elements = elements;
  }
}

%extend IPLRenderingSettings {
  IPLRenderingSettings(IPLint32 samplingRate, IPLint32 frameSize, IPLConvolutionType convolutionType) {
    this->samplingRate = samplingRate;
    this->frameSize = frameSize;
    this->convolutionType = convolutionType;
  }
}

%extend IPLAudioFormat {
  IPLAudioFormat(
      IPLChannelLayoutType        channelLayoutType,
      IPLChannelLayout            channelLayout,
      IPLint32                    numSpeakers,
      IPLVector3*                 speakerDirections,
      IPLint32                    ambisonicsOrder,
      IPLAmbisonicsOrdering       ambisonicsOrdering,
      IPLAmbisonicsNormalization  ambisonicsNormalization,
      IPLChannelOrder             channelOrder
      ) {
    this->channelLayoutType = channelLayoutType;
    this->channelLayout = channelLayout;
    this->numSpeakers = numSpeakers;
    this->speakerDirections = speakerDirections;
    this->ambisonicsOrder = ambisonicsOrder;
    this->ambisonicsOrdering = ambisonicsOrdering;
    this->ambisonicsNormalization = ambisonicsNormalization;
    this->channelOrder = channelOrder;
  }
}

%extend IPLAudioFormat {
  IPLAudioFormat(
      IPLChannelLayoutType        channelLayoutType,
      IPLChannelLayout            channelLayout,
      IPLChannelOrder             channelOrder
      ) {
    this->channelLayoutType = channelLayoutType;
    this->channelLayout = channelLayout;
    this->channelOrder = channelOrder;
  }
}

%extend IPLAudioFormat {
  IPLAudioFormat(
      IPLChannelLayoutType        channelLayoutType,
      IPLChannelLayout            channelLayout,
      IPLint32                    numSpeakers,
      IPLVector3*                 speakerDirections,
      IPLChannelOrder             channelOrder
      ) {
    this->channelLayoutType = channelLayoutType;
    this->channelLayout = channelLayout;
    this->numSpeakers = numSpeakers;
    this->speakerDirections = speakerDirections;
    this->channelOrder = channelOrder;
  }
}

%extend IPLAudioFormat {
  IPLAudioFormat(
      IPLChannelLayoutType        channelLayoutType,
      IPLint32                    ambisonicsOrder,
      IPLAmbisonicsOrdering       ambisonicsOrdering,
      IPLAmbisonicsNormalization  ambisonicsNormalization,
      IPLChannelOrder             channelOrder
      ) {
    this->channelLayoutType = channelLayoutType;
    this->ambisonicsOrder = ambisonicsOrder;
    this->ambisonicsOrdering = ambisonicsOrdering;
    this->ambisonicsNormalization = ambisonicsNormalization;
    this->channelOrder = channelOrder;
  }
}

%extend IPLAudioBuffer {
  IPLAudioBuffer(IPLAudioFormat format, IPLint32 numSamples, IPLfloat32* interleavedBuffer, IPLfloat32** deinterleavedBuffer) {
    this->format = format;
    this->numSamples = numSamples;
    this->interleavedBuffer = interleavedBuffer;
    this->deinterleavedBuffer = deinterleavedBuffer;
  }
}

%extend IPLAudioBuffer {
  IPLAudioBuffer(IPLAudioFormat format, IPLint32 numSamples, IPLfloat32** deinterleavedBuffer) {
    this->format = format;
    this->numSamples = numSamples;
    this->interleavedBuffer = NULL;
    this->deinterleavedBuffer = deinterleavedBuffer;
  }
}

%extend IPLAudioBuffer {
  IPLAudioBuffer(IPLAudioFormat format, IPLint32 numSamples, IPLfloat32* interleavedBuffer) {
    this->format = format;
    this->numSamples = numSamples;
    this->interleavedBuffer = interleavedBuffer;
    this->deinterleavedBuffer = NULL;
  }
}

%extend IPLHrtfParams {
  IPLHrtfParams(IPLHrtfDatabaseType type, IPLbyte* hrtfData, IPLstring sofaFileName) {
    this->type = type;
    this->hrtfData = hrtfData;
    this-> sofaFileName;
  }
}

%extend IPLDistanceAttenuationModel {
  IPLDistanceAttenuationModel(
  IPLDistanceAttenuationModelType type,
  IPLfloat32 minDistance,
  IPLDistanceAttenuationCallback callback,
  void* userData,
  IPLbool dirty
  ) {
  this->type = type;
  this->minDistance = minDistance;
  this->callback = callback;
  this->dirty = dirty;
  }
}

%extend IPLDistanceAttenuationModel {
  IPLDistanceAttenuationModel(
  IPLDistanceAttenuationModelType type,
  IPLDistanceAttenuationCallback callback,
  void* userData,
  IPLbool dirty
  ) {
  this->type = type;
  this->callback = callback;
  this->dirty = dirty;
  }
}

%extend IPLDistanceAttenuationModel {
  IPLDistanceAttenuationModel(
  IPLDistanceAttenuationModelType type,
  IPLfloat32 minDistance
  ) {
  this->type = type;
  this->minDistance = minDistance;
  }
}

%extend IPLAirAbsorptionModel {
  IPLAirAbsorptionModel(
  IPLAirAbsorptionModelType type,
  IPLfloat32 coefficients[],
  IPLAirAbsorptionCallback callback,
  void* userData,
  IPLbool dirty
  ) {
  this->type = type;
  this->coefficients = coefficients;
  this->callback = callback;
  this->dirty = dirty;
  }
}

%extend IPLAirAbsorptionModel {
  IPLAirAbsorptionModel(
  IPLAirAbsorptionModelType type,
  IPLfloat32 coefficients[]
  ) {
  this->type = type;
  this->coefficients = coefficients;
  }
}

%extend IPLAirAbsorptionModel {
  IPLAirAbsorptionModel(
  IPLAirAbsorptionModelType type,
  IPLAirAbsorptionCallback callback,
  void* userData,
  IPLbool dirty
  ) {
  this->type = type;
  this->callback = callback;
  this->dirty = dirty;
  }
}
%extend IPLDirectSoundPath {
  IPLDirectSoundPath(
  IPLVector3 direction,
  IPLfloat32 distanceAttenuation,
  IPLfloat32 airAbsorption[],
  IPLfloat32 propagationDelay,
  IPLfloat32 occlusionFactor,
  IPLfloat32 transmissionFactor[],
  IPLfloat32 directivityFactor
  ) {
  this->direction = direction;
  this->distanceAttenuation = distanceAttenuation;
  this->airAbsorption = airAbsorption;
  this->propagationDelay = propagationDelay;
  this->occlusionFactor = occlusionFactor;
  this->transmissionFactor = transmissionFactor;
  this->directivityFactor = directivityFactor;
  }
}

%extend IPLDirectivity {
  IPLDirectivity(
  IPLfloat32 dipoleWeight,
  IPLfloat32 dipolePower,
  IPLDirectivityCallback callback,
  void* userData
  ) {
  this->dipoleWeight = dipoleWeight;
  this->dipolePower = dipolePower;
  this->callback = callback;
  }
}

%extend IPLSource {
  IPLSource(
  IPLVector3 position,
  IPLVector3 ahead,
  IPLVector3 up,
  IPLVector3 right,
  IPLDirectivity directivity,
  IPLDistanceAttenuationModel distanceAttenuationModel,
  IPLAirAbsorptionModel airAbsorptionModel
  ) {
  this->position = position;
  this->ahead = ahead;
  this->up = up;
  this->right = right;
  this->directivity = directivity;
  this->distanceAttenuationModel = distanceAttenuationModel;
  this->airAbsorptionModel = airAbsorptionModel;
  }
}

%extend IPLDirectSoundEffectOptions {
  IPLDirectSoundEffectOptions(
  IPLbool applyDistanceAttenuation,
  IPLbool applyAirAbsorption,
  IPLbool applyDirectivity,
  IPLDiretOcclusionMode directOcclusionMode
  ) {
  this->applyDistanceAttenuation = applyDistanceAttenuation;
  this->applyAirAbsorption = applyAirAbsorption;
  this->applyDirectivity = applyDirectivity;
  this->directOcclusionMode = directOcclusionMode;
  }
}

%extend IPLBakedDataIdentifier {
  IPLBakedDataIdentifier(IPLint32 identifier, IPLBakedDataType type) {
    this->identifier = identifier;
    this->type = type;
  }
}

%extend IPLProbePlacementParams {
  IPLProbePlacementParams(
  IPLProbePlacement placement,
  IPLfloat32 spacing,
  IPLfloat32 heightAboveFloor,
  IPLint32 maxOctreeTriangles,
  IPLint32 maxOctreeDepth
  ) {
    this->placement = placement;
    this->spacing = spacing;
    this->heightAboveFloor = heightAboveFloor;
    this->maxOctreeTriangles = maxOctreeTriangles;
    this->maxOctreeDepth = maxOctreeDepth;
  }
}

%extend IPLBakingSettings {
  IPLBakingSettings(
  IPLbool bakeParametric,
  IPLbool bakeConvolution,
  IPLfloat32 irDurationForBake
  ) {
    this->bakeParametric = bakeParametric;
    this->bakeConvolution = bakeConvolution;
    this->irDurationForBake = irDurationForBake;
  }
}
*/
/* Parse the header file to generate wrappers */
%include "phonon.h"
%include "phonon_version.h"
