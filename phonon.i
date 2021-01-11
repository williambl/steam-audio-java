%module phonon
%{
  /* Includes the header in the wrapper code */
#include "phonon.h"
#include "phonon_version.h"
  %}

  %include "enums.swg"
  %include "arrays_java.i";
  %javaconst(1);

  %apply bool { enum IPLbool };


%extend IPLVector3 {
  IPLVector3(int x, int y, int z) {
    $self->x = x;
    $self->y = y;
    $self->z = z;
  }
}

%extend IPLBox {
  IPLBox(IPLVector3 minCoords, IPLVector3 maxCoords) {
    $self->minCoordinates = minCoords;
    $self->maxCoordinates = maxCoords;
  }
}

%extend IPLSphere {
  IPLSphere(IPLVector3 center, IPLfloat32 radius) {
    $self->center = center;
    $self->radius = radius;
  }
}

%extend IPLComputeDeviceFilter {
  IPLComputeDeviceFilter(IPLComputeDeviceType type, IPLint32 maxCUsToReserve, IPLfloat32 fractionCUsForIRUpdate) {
    $self->type = type;
    $self->maxCUsToReserve = maxCUsToReserve;
    $self->fractionCUsForIRUpdate = fractionCUsForIRUpdate;
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
    self->sceneType = sceneType;
    self->maxNumOcclusionSamples = maxNumOcclusionSamples;
    self->numRays = numRays;
    self->numDiffuseSamples = numDiffuseSamples;
    self->numBounces = numBounces;
    self->numThreads = numThreads;
    self->irDuration = irDuration;
    self->ambisonicsOrder = ambisonicsOrder;
    self->maxConvolutionSources = maxConvolutionSources;
    self->bakingBatchSize = bakingBatchSize;
    self->irradianceMinDistance = irradianceMinDistance;
  }
}

%extend IPLTriangle {
  IPLTriangle(IPLint32 indices[]) {
    self->indices = indices;
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
    self->lowFreqAbsorption = lowFreqAbsorption;
    self->midFreqAbsorption = midFreqAbsorption;
    self->highFreqAbsorption = highFreqAbsorption;
    self->scattering = scattering;
    self->lowFreqTransmission = lowFreqTransmission;
    self->midFreqTransmission = midFreqTransmission;
    self->highFreqTransmission = highFreqTransmission;
  }
}

%extend IPLMatrix4x4 {
  IPLMatrix4x4(float elements[][]) {
    self->elements = elements;
  }
}

%extend IPLRenderingSettings {
  IPLRenderingSettings(IPLint32 samplingRate, IPLint32 frameSize, IPLConvolutionType convolutionType) {
    self->samplingRate = samplingRate;
    self->frameSize = frameSize;
    self->convolutionType = convolutionType;
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
    self->channelLayoutType = channelLayoutType;
    self->channelLayout = channelLayout;
    self->numSpeakers = numSpeakers;
    self->speakerDirections = speakerDirections;
    self->ambisonicsOrder = ambisonicsOrder;
    self->ambisonicsOrdering = ambisonicsOrdering;
    self->ambisonicsNormalization = ambisonicsNormalization;
    self->channelOrder = channelOrder;
  }
}

%extend IPLAudioBuffer {
  IPLAudioBuffer(IPLAudioFormat format, IPLint32 numSamples, IPLfloat32* interleavedBuffer, IPLfloat32** deinterleavedBuffer) {
    self->format = format;
    self->numSamples = numSamples;
    self->interleavedBuffer = interleavedBuffer;
    self->deinterleavedBuffer = deinterleavedBuffer;
  }
}

%extend IPLHrtfParams {
  IPLHrtfParams(IPLHrtfDatabaseType type, IPLbyte* hrtfData, IPLstring sofaFileName) {
    self->type = type;
    self->hrtfData = hrtfData;
    self-> sofaFileName;
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
  self->type = type;
  self->minDistance = minDistance;
  self->callback = callback;
  self->dirty = dirty;
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
  self->type = type;
  self->coefficients = coefficients;
  self->callback = callback;
  self->dirty = dirty;
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
  self->direction = direction;
  self->distanceAttenuation = distanceAttenuation;
  self->airAbsorption = airAbsorption;
  self->propagationDelay = propagationDelay;
  self->occlusionFactor = occlusionFactor;
  self->transmissionFactor = transmissionFactor;
  self->directivityFactor = directivityFactor;
  }
}

%extend IPLDirectivity {
  IPLDirectivity(
  IPLfloat32 dipoleWeight,
  IPLfloat32 dipolePower,
  IPLDirectivityCallback callback,
  void* userData
  ) {
  self->dipoleWeight = dipoleWeight;
  self->dipolePower = dipolePower;
  self->callback = callback;
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
  self->position = position;
  self->ahead = ahead;
  self->up = up;
  self->right = right;
  self->directivity = directivity;
  self->distanceAttenuationModel = distanceAttenuationModel;
  self->airAbsorptionModel = airAbsorptionModel;
  }
}

%extend IPLDirectSoundEffectOptions {
  IPLDirectSoundEffectOptions(
  IPLbool applyDistanceAttenuation,
  IPLbool applyAirAbsorption,
  IPLbool applyDirectivity,
  IPLDiretOcclusionMode directOcclusionMode
  ) {
  self->applyDistanceAttenuation = applyDistanceAttenuation;
  self->applyAirAbsorption = applyAirAbsorption;
  self->applyDirectivity = applyDirectivity;
  self->directOcclusionMode = directOcclusionMode;
  }
}

%extend IPLBakedDataIdentifier {
  IPLBakedDataIdentifier(IPLint32 identifier, IPLBakedDataType type) {
    self->identifier = identifier;
    self->type = type;
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
    self->placement = placement;
    self->spacing = spacing;
    self->heightAboveFloor = heightAboveFloor;
    self->maxOctreeTriangles = maxOctreeTriangles;
    self->maxOctreeDepth = maxOctreeDepth;
  }
}

%extend IPLBakingSettings {
  IPLBakingSettings(
  IPLbool bakeParametric,
  IPLbool bakeConvolution,
  IPLfloat32 irDurationForBake
  ) {
    self->bakeParametric = bakeParametric;
    self->bakeConvolution = bakeConvolution;
    self->irDurationForBake = irDurationForBake;
  }
}

/* Parse the header file to generate wrappers */
%include "phonon.h"
%include "phonon_version.h"
