# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


module Google
  module Cloud
    module VideoIntelligence
      module V1
        # Video annotation request.
        # @!attribute [rw] input_uri
        #   @return [String]
        #     Input video location. Currently, only
        #     [Google Cloud Storage](https://cloud.google.com/storage/) URIs are
        #     supported, which must be specified in the following format:
        #     `gs://bucket-id/object-id` (other URI formats return
        #     {Google::Rpc::Code::INVALID_ARGUMENT}). For more information, see
        #     [Request URIs](https://cloud.google.com/storage/docs/request-endpoints).
        #     A video URI may include wildcards in `object-id`, and thus identify
        #     multiple videos. Supported wildcards: '*' to match 0 or more characters;
        #     '?' to match 1 character. If unset, the input video should be embedded
        #     in the request as `input_content`. If set, `input_content` should be unset.
        # @!attribute [rw] input_content
        #   @return [String]
        #     The video data bytes.
        #     If unset, the input video(s) should be specified via `input_uri`.
        #     If set, `input_uri` should be unset.
        # @!attribute [rw] features
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::Feature>]
        #     Required. Requested video annotation features.
        # @!attribute [rw] video_context
        #   @return [Google::Cloud::VideoIntelligence::V1::VideoContext]
        #     Additional video context and/or feature-specific parameters.
        # @!attribute [rw] output_uri
        #   @return [String]
        #     Optional. Location where the output (in JSON format) should be stored.
        #     Currently, only [Google Cloud Storage](https://cloud.google.com/storage/)
        #     URIs are supported, which must be specified in the following format:
        #     `gs://bucket-id/object-id` (other URI formats return
        #     {Google::Rpc::Code::INVALID_ARGUMENT}). For more information, see
        #     [Request URIs](https://cloud.google.com/storage/docs/request-endpoints).
        # @!attribute [rw] location_id
        #   @return [String]
        #     Optional. Cloud region where annotation should take place. Supported cloud
        #     regions: `us-east1`, `us-west1`, `europe-west1`, `asia-east1`. If no region
        #     is specified, a region will be determined based on video file location.
        class AnnotateVideoRequest; end

        # Video context and/or feature-specific parameters.
        # @!attribute [rw] segments
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::VideoSegment>]
        #     Video segments to annotate. The segments may overlap and are not required
        #     to be contiguous or span the whole video. If unspecified, each video is
        #     treated as a single segment.
        # @!attribute [rw] label_detection_config
        #   @return [Google::Cloud::VideoIntelligence::V1::LabelDetectionConfig]
        #     Config for LABEL_DETECTION.
        # @!attribute [rw] shot_change_detection_config
        #   @return [Google::Cloud::VideoIntelligence::V1::ShotChangeDetectionConfig]
        #     Config for SHOT_CHANGE_DETECTION.
        # @!attribute [rw] explicit_content_detection_config
        #   @return [Google::Cloud::VideoIntelligence::V1::ExplicitContentDetectionConfig]
        #     Config for EXPLICIT_CONTENT_DETECTION.
        # @!attribute [rw] face_detection_config
        #   @return [Google::Cloud::VideoIntelligence::V1::FaceDetectionConfig]
        #     Config for FACE_DETECTION.
        # @!attribute [rw] speech_transcription_config
        #   @return [Google::Cloud::VideoIntelligence::V1::SpeechTranscriptionConfig]
        #     Config for SPEECH_TRANSCRIPTION.
        # @!attribute [rw] text_detection_config
        #   @return [Google::Cloud::VideoIntelligence::V1::TextDetectionConfig]
        #     Config for TEXT_DETECTION.
        # @!attribute [rw] object_tracking_config
        #   @return [Google::Cloud::VideoIntelligence::V1::ObjectTrackingConfig]
        #     Config for OBJECT_TRACKING.
        class VideoContext; end

        # Config for LABEL_DETECTION.
        # @!attribute [rw] label_detection_mode
        #   @return [Google::Cloud::VideoIntelligence::V1::LabelDetectionMode]
        #     What labels should be detected with LABEL_DETECTION, in addition to
        #     video-level labels or segment-level labels.
        #     If unspecified, defaults to `SHOT_MODE`.
        # @!attribute [rw] stationary_camera
        #   @return [true, false]
        #     Whether the video has been shot from a stationary (i.e. non-moving) camera.
        #     When set to true, might improve detection accuracy for moving objects.
        #     Should be used with `SHOT_AND_FRAME_MODE` enabled.
        # @!attribute [rw] model
        #   @return [String]
        #     Model to use for label detection.
        #     Supported values: "builtin/stable" (the default if unset) and
        #     "builtin/latest".
        # @!attribute [rw] frame_confidence_threshold
        #   @return [Float]
        #     The confidence threshold we perform filtering on the labels from
        #     frame-level detection. If not set, it is set to 0.4 by default. The valid
        #     range for this threshold is [0.1, 0.9]. Any value set outside of this
        #     range will be clipped.
        #     Note: for best results please follow the default threshold. We will update
        #     the default threshold everytime when we release a new model.
        # @!attribute [rw] video_confidence_threshold
        #   @return [Float]
        #     The confidence threshold we perform filtering on the labels from
        #     video-level and shot-level detections. If not set, it is set to 0.3 by
        #     default. The valid range for this threshold is [0.1, 0.9]. Any value set
        #     outside of this range will be clipped.
        #     Note: for best results please follow the default threshold. We will update
        #     the default threshold everytime when we release a new model.
        class LabelDetectionConfig; end

        # Config for SHOT_CHANGE_DETECTION.
        # @!attribute [rw] model
        #   @return [String]
        #     Model to use for shot change detection.
        #     Supported values: "builtin/stable" (the default if unset) and
        #     "builtin/latest".
        class ShotChangeDetectionConfig; end

        # Config for OBJECT_TRACKING.
        # @!attribute [rw] model
        #   @return [String]
        #     Model to use for object tracking.
        #     Supported values: "builtin/stable" (the default if unset) and
        #     "builtin/latest".
        class ObjectTrackingConfig; end

        # Config for FACE_DETECTION.
        # @!attribute [rw] model
        #   @return [String]
        #     Model to use for face detection.
        #     Supported values: "builtin/stable" (the default if unset) and
        #     "builtin/latest".
        # @!attribute [rw] include_bounding_boxes
        #   @return [true, false]
        #     Whether bounding boxes be included in the face annotation output.
        class FaceDetectionConfig; end

        # Config for EXPLICIT_CONTENT_DETECTION.
        # @!attribute [rw] model
        #   @return [String]
        #     Model to use for explicit content detection.
        #     Supported values: "builtin/stable" (the default if unset) and
        #     "builtin/latest".
        class ExplicitContentDetectionConfig; end

        # Config for TEXT_DETECTION.
        # @!attribute [rw] language_hints
        #   @return [Array<String>]
        #     Language hint can be specified if the language to be detected is known a
        #     priori. It can increase the accuracy of the detection. Language hint must
        #     be language code in BCP-47 format.
        #
        #     Automatic language detection is performed if no hint is provided.
        # @!attribute [rw] model
        #   @return [String]
        #     Model to use for text detection.
        #     Supported values: "builtin/stable" (the default if unset) and
        #     "builtin/latest".
        class TextDetectionConfig; end

        # Video segment.
        # @!attribute [rw] start_time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video,
        #     corresponding to the start of the segment (inclusive).
        # @!attribute [rw] end_time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video,
        #     corresponding to the end of the segment (inclusive).
        class VideoSegment; end

        # Video segment level annotation results for label detection.
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1::VideoSegment]
        #     Video segment where a label was detected.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Confidence that the label is accurate. Range: [0, 1].
        class LabelSegment; end

        # Video frame level annotation results for label detection.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video, corresponding to the
        #     video frame for this location.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Confidence that the label is accurate. Range: [0, 1].
        class LabelFrame; end

        # Detected entity from video analysis.
        # @!attribute [rw] entity_id
        #   @return [String]
        #     Opaque entity ID. Some IDs may be available in
        #     [Google Knowledge Graph Search
        #     API](https://developers.google.com/knowledge-graph/).
        # @!attribute [rw] description
        #   @return [String]
        #     Textual description, e.g. `Fixed-gear bicycle`.
        # @!attribute [rw] language_code
        #   @return [String]
        #     Language code for `description` in BCP-47 format.
        class Entity; end

        # Label annotation.
        # @!attribute [rw] entity
        #   @return [Google::Cloud::VideoIntelligence::V1::Entity]
        #     Detected entity.
        # @!attribute [rw] category_entities
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::Entity>]
        #     Common categories for the detected entity.
        #     E.g. when the label is `Terrier` the category is likely `dog`. And in some
        #     cases there might be more than one categories e.g. `Terrier` could also be
        #     a `pet`.
        # @!attribute [rw] segments
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::LabelSegment>]
        #     All video segments where a label was detected.
        # @!attribute [rw] frames
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::LabelFrame>]
        #     All video frames where a label was detected.
        class LabelAnnotation; end

        # Video frame level annotation results for explicit content.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video, corresponding to the
        #     video frame for this location.
        # @!attribute [rw] pornography_likelihood
        #   @return [Google::Cloud::VideoIntelligence::V1::Likelihood]
        #     Likelihood of the pornography content..
        class ExplicitContentFrame; end

        # Explicit content annotation (based on per-frame visual signals only).
        # If no explicit content has been detected in a frame, no annotations are
        # present for that frame.
        # @!attribute [rw] frames
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::ExplicitContentFrame>]
        #     All video frames where explicit content was detected.
        class ExplicitContentAnnotation; end

        # Normalized bounding box.
        # The normalized vertex coordinates are relative to the original image.
        # Range: [0, 1].
        # @!attribute [rw] left
        #   @return [Float]
        #     Left X coordinate.
        # @!attribute [rw] top
        #   @return [Float]
        #     Top Y coordinate.
        # @!attribute [rw] right
        #   @return [Float]
        #     Right X coordinate.
        # @!attribute [rw] bottom
        #   @return [Float]
        #     Bottom Y coordinate.
        class NormalizedBoundingBox; end

        # Video segment level annotation results for face detection.
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1::VideoSegment]
        #     Video segment where a face was detected.
        class FaceSegment; end

        # Video frame level annotation results for face detection.
        # @!attribute [rw] normalized_bounding_boxes
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::NormalizedBoundingBox>]
        #     Normalized Bounding boxes in a frame.
        #     There can be more than one boxes if the same face is detected in multiple
        #     locations within the current frame.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video,
        #     corresponding to the video frame for this location.
        class FaceFrame; end

        # Face annotation.
        # @!attribute [rw] thumbnail
        #   @return [String]
        #     Thumbnail of a representative face view (in JPEG format).
        # @!attribute [rw] segments
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::FaceSegment>]
        #     All video segments where a face was detected.
        # @!attribute [rw] frames
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::FaceFrame>]
        #     All video frames where a face was detected.
        class FaceAnnotation; end

        # For tracking related features.
        # An object at time_offset with attributes, and located with
        # normalized_bounding_box.
        # @!attribute [rw] normalized_bounding_box
        #   @return [Google::Cloud::VideoIntelligence::V1::NormalizedBoundingBox]
        #     Normalized Bounding box in a frame, where the object is located.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     Time-offset, relative to the beginning of the video,
        #     corresponding to the video frame for this object.
        # @!attribute [rw] attributes
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::DetectedAttribute>]
        #     Optional. The attributes of the object in the bounding box.
        # @!attribute [rw] landmarks
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::DetectedLandmark>]
        #     Optional. The detected landmarks.
        class TimestampedObject; end

        # A track of an object instance.
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1::VideoSegment]
        #     Video segment of a track.
        # @!attribute [rw] timestamped_objects
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::TimestampedObject>]
        #     The object with timestamp and attributes per frame in the track.
        # @!attribute [rw] attributes
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::DetectedAttribute>]
        #     Optional. Attributes in the track level.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Optional. The confidence score of the tracked object.
        class Track; end

        # A generic detected attribute represented by name in string format.
        # @!attribute [rw] name
        #   @return [String]
        #     The name of the attribute, i.e. glasses, dark_glasses, mouth_open etc.
        #     A full list of supported type names will be provided in the document.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Detected attribute confidence. Range [0, 1].
        # @!attribute [rw] value
        #   @return [String]
        #     Text value of the detection result. For example, the value for "HairColor"
        #     can be "black", "blonde", etc.
        class DetectedAttribute; end

        # A generic detected landmark represented by name in string format and a 2D
        # location.
        # @!attribute [rw] name
        #   @return [String]
        #     The name of this landmark, i.e. left_hand, right_shoulder.
        # @!attribute [rw] point
        #   @return [Google::Cloud::VideoIntelligence::V1::NormalizedVertex]
        #     The 2D point of the detected landmark using the normalized image
        #     coordindate system. The normalized coordinates have the range from 0 to 1.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     The confidence score of the detected landmark. Range [0, 1].
        class DetectedLandmark; end

        # Annotation results for a single video.
        # @!attribute [rw] input_uri
        #   @return [String]
        #     Video file location in
        #     [Google Cloud Storage](https://cloud.google.com/storage/).
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1::VideoSegment]
        #     Video segment on which the annotation is run.
        # @!attribute [rw] segment_label_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::LabelAnnotation>]
        #     Topical label annotations on video level or user specified segment level.
        #     There is exactly one element for each unique label.
        # @!attribute [rw] segment_presence_label_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::LabelAnnotation>]
        #     Presence label annotations on video level or user specified segment level.
        #     There is exactly one element for each unique label. Compared to the
        #     existing topical `segment_label_annotations`, this field presents more
        #     fine-grained, segment-level labels detected in video content and is made
        #     available only when the client sets `LabelDetectionConfig.model` to
        #     "builtin/latest" in the request.
        # @!attribute [rw] shot_label_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::LabelAnnotation>]
        #     Topical label annotations on shot level.
        #     There is exactly one element for each unique label.
        # @!attribute [rw] shot_presence_label_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::LabelAnnotation>]
        #     Presence label annotations on shot level. There is exactly one element for
        #     each unique label. Compared to the existing topical
        #     `shot_label_annotations`, this field presents more fine-grained, shot-level
        #     labels detected in video content and is made available only when the client
        #     sets `LabelDetectionConfig.model` to "builtin/latest" in the request.
        # @!attribute [rw] frame_label_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::LabelAnnotation>]
        #     Label annotations on frame level.
        #     There is exactly one element for each unique label.
        # @!attribute [rw] face_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::FaceAnnotation>]
        #     Face annotations. There is exactly one element for each unique face.
        # @!attribute [rw] shot_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::VideoSegment>]
        #     Shot annotations. Each shot is represented as a video segment.
        # @!attribute [rw] explicit_annotation
        #   @return [Google::Cloud::VideoIntelligence::V1::ExplicitContentAnnotation]
        #     Explicit content annotation.
        # @!attribute [rw] speech_transcriptions
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::SpeechTranscription>]
        #     Speech transcription.
        # @!attribute [rw] text_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::TextAnnotation>]
        #     OCR text detection and tracking.
        #     Annotations for list of detected text snippets. Each will have list of
        #     frame information associated with it.
        # @!attribute [rw] object_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::ObjectTrackingAnnotation>]
        #     Annotations for list of objects detected and tracked in video.
        # @!attribute [rw] logo_recognition_annotations
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::LogoRecognitionAnnotation>]
        #     Annotations for list of logos detected, tracked and recognized in video.
        # @!attribute [rw] error
        #   @return [Google::Rpc::Status]
        #     If set, indicates an error. Note that for a single `AnnotateVideoRequest`
        #     some videos may succeed and some may fail.
        class VideoAnnotationResults; end

        # Video annotation response. Included in the `response`
        # field of the `Operation` returned by the `GetOperation`
        # call of the `google::longrunning::Operations` service.
        # @!attribute [rw] annotation_results
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::VideoAnnotationResults>]
        #     Annotation results for all videos specified in `AnnotateVideoRequest`.
        class AnnotateVideoResponse; end

        # Annotation progress for a single video.
        # @!attribute [rw] input_uri
        #   @return [String]
        #     Video file location in
        #     [Google Cloud Storage](https://cloud.google.com/storage/).
        # @!attribute [rw] progress_percent
        #   @return [Integer]
        #     Approximate percentage processed thus far. Guaranteed to be
        #     100 when fully processed.
        # @!attribute [rw] start_time
        #   @return [Google::Protobuf::Timestamp]
        #     Time when the request was received.
        # @!attribute [rw] update_time
        #   @return [Google::Protobuf::Timestamp]
        #     Time of the most recent update.
        # @!attribute [rw] feature
        #   @return [Google::Cloud::VideoIntelligence::V1::Feature]
        #     Specifies which feature is being tracked if the request contains more than
        #     one features.
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1::VideoSegment]
        #     Specifies which segment is being tracked if the request contains more than
        #     one segments.
        class VideoAnnotationProgress; end

        # Video annotation progress. Included in the `metadata`
        # field of the `Operation` returned by the `GetOperation`
        # call of the `google::longrunning::Operations` service.
        # @!attribute [rw] annotation_progress
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::VideoAnnotationProgress>]
        #     Progress metadata for all videos specified in `AnnotateVideoRequest`.
        class AnnotateVideoProgress; end

        # Config for SPEECH_TRANSCRIPTION.
        # @!attribute [rw] language_code
        #   @return [String]
        #     Required. *Required* The language of the supplied audio as a
        #     [BCP-47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) language tag.
        #     Example: "en-US".
        #     See [Language Support](https://cloud.google.com/speech/docs/languages)
        #     for a list of the currently supported language codes.
        # @!attribute [rw] max_alternatives
        #   @return [Integer]
        #     Optional. Maximum number of recognition hypotheses to be returned.
        #     Specifically, the maximum number of `SpeechRecognitionAlternative` messages
        #     within each `SpeechTranscription`. The server may return fewer than
        #     `max_alternatives`. Valid values are `0`-`30`. A value of `0` or `1` will
        #     return a maximum of one. If omitted, will return a maximum of one.
        # @!attribute [rw] filter_profanity
        #   @return [true, false]
        #     Optional. If set to `true`, the server will attempt to filter out
        #     profanities, replacing all but the initial character in each filtered word
        #     with asterisks, e.g. "f***". If set to `false` or omitted, profanities
        #     won't be filtered out.
        # @!attribute [rw] speech_contexts
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::SpeechContext>]
        #     Optional. A means to provide context to assist the speech recognition.
        # @!attribute [rw] enable_automatic_punctuation
        #   @return [true, false]
        #     Optional. If 'true', adds punctuation to recognition result hypotheses.
        #     This feature is only available in select languages. Setting this for
        #     requests in other languages has no effect at all. The default 'false' value
        #     does not add punctuation to result hypotheses. NOTE: "This is currently
        #     offered as an experimental service, complimentary to all users. In the
        #     future this may be exclusively available as a premium feature."
        # @!attribute [rw] audio_tracks
        #   @return [Array<Integer>]
        #     Optional. For file formats, such as MXF or MKV, supporting multiple audio
        #     tracks, specify up to two tracks. Default: track 0.
        # @!attribute [rw] enable_speaker_diarization
        #   @return [true, false]
        #     Optional. If 'true', enables speaker detection for each recognized word in
        #     the top alternative of the recognition result using a speaker_tag provided
        #     in the WordInfo.
        #     Note: When this is true, we send all the words from the beginning of the
        #     audio for the top alternative in every consecutive responses.
        #     This is done in order to improve our speaker tags as our models learn to
        #     identify the speakers in the conversation over time.
        # @!attribute [rw] diarization_speaker_count
        #   @return [Integer]
        #     Optional. If set, specifies the estimated number of speakers in the conversation.
        #     If not set, defaults to '2'.
        #     Ignored unless enable_speaker_diarization is set to true.
        # @!attribute [rw] enable_word_confidence
        #   @return [true, false]
        #     Optional. If `true`, the top result includes a list of words and the
        #     confidence for those words. If `false`, no word-level confidence
        #     information is returned. The default is `false`.
        class SpeechTranscriptionConfig; end

        # Provides "hints" to the speech recognizer to favor specific words and phrases
        # in the results.
        # @!attribute [rw] phrases
        #   @return [Array<String>]
        #     Optional. A list of strings containing words and phrases "hints" so that
        #     the speech recognition is more likely to recognize them. This can be used
        #     to improve the accuracy for specific words and phrases, for example, if
        #     specific commands are typically spoken by the user. This can also be used
        #     to add additional words to the vocabulary of the recognizer. See
        #     [usage limits](https://cloud.google.com/speech/limits#content).
        class SpeechContext; end

        # A speech recognition result corresponding to a portion of the audio.
        # @!attribute [rw] alternatives
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::SpeechRecognitionAlternative>]
        #     May contain one or more recognition hypotheses (up to the maximum specified
        #     in `max_alternatives`).  These alternatives are ordered in terms of
        #     accuracy, with the top (first) alternative being the most probable, as
        #     ranked by the recognizer.
        # @!attribute [rw] language_code
        #   @return [String]
        #     Output only. The [BCP-47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) language tag of
        #     the language in this result. This language code was detected to have the
        #     most likelihood of being spoken in the audio.
        class SpeechTranscription; end

        # Alternative hypotheses (a.k.a. n-best list).
        # @!attribute [rw] transcript
        #   @return [String]
        #     Transcript text representing the words that the user spoke.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Output only. The confidence estimate between 0.0 and 1.0. A higher number
        #     indicates an estimated greater likelihood that the recognized words are
        #     correct. This field is set only for the top alternative.
        #     This field is not guaranteed to be accurate and users should not rely on it
        #     to be always provided.
        #     The default of 0.0 is a sentinel value indicating `confidence` was not set.
        # @!attribute [rw] words
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::WordInfo>]
        #     Output only. A list of word-specific information for each recognized word.
        #     Note: When `enable_speaker_diarization` is true, you will see all the words
        #     from the beginning of the audio.
        class SpeechRecognitionAlternative; end

        # Word-specific information for recognized words. Word information is only
        # included in the response when certain request parameters are set, such
        # as `enable_word_time_offsets`.
        # @!attribute [rw] start_time
        #   @return [Google::Protobuf::Duration]
        #     Time offset relative to the beginning of the audio, and
        #     corresponding to the start of the spoken word. This field is only set if
        #     `enable_word_time_offsets=true` and only in the top hypothesis. This is an
        #     experimental feature and the accuracy of the time offset can vary.
        # @!attribute [rw] end_time
        #   @return [Google::Protobuf::Duration]
        #     Time offset relative to the beginning of the audio, and
        #     corresponding to the end of the spoken word. This field is only set if
        #     `enable_word_time_offsets=true` and only in the top hypothesis. This is an
        #     experimental feature and the accuracy of the time offset can vary.
        # @!attribute [rw] word
        #   @return [String]
        #     The word corresponding to this set of information.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Output only. The confidence estimate between 0.0 and 1.0. A higher number
        #     indicates an estimated greater likelihood that the recognized words are
        #     correct. This field is set only for the top alternative.
        #     This field is not guaranteed to be accurate and users should not rely on it
        #     to be always provided.
        #     The default of 0.0 is a sentinel value indicating `confidence` was not set.
        # @!attribute [rw] speaker_tag
        #   @return [Integer]
        #     Output only. A distinct integer value is assigned for every speaker within
        #     the audio. This field specifies which one of those speakers was detected to
        #     have spoken this word. Value ranges from 1 up to diarization_speaker_count,
        #     and is only set if speaker diarization is enabled.
        class WordInfo; end

        # A vertex represents a 2D point in the image.
        # NOTE: the normalized vertex coordinates are relative to the original image
        # and range from 0 to 1.
        # @!attribute [rw] x
        #   @return [Float]
        #     X coordinate.
        # @!attribute [rw] y
        #   @return [Float]
        #     Y coordinate.
        class NormalizedVertex; end

        # Normalized bounding polygon for text (that might not be aligned with axis).
        # Contains list of the corner points in clockwise order starting from
        # top-left corner. For example, for a rectangular bounding box:
        # When the text is horizontal it might look like:
        #         0----1
        #         |    |
        #         3----2
        #
        # When it's clockwise rotated 180 degrees around the top-left corner it
        # becomes:
        #         2----3
        #         |    |
        #         1----0
        #
        # and the vertex order will still be (0, 1, 2, 3). Note that values can be less
        # than 0, or greater than 1 due to trignometric calculations for location of
        # the box.
        # @!attribute [rw] vertices
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::NormalizedVertex>]
        #     Normalized vertices of the bounding polygon.
        class NormalizedBoundingPoly; end

        # Video segment level annotation results for text detection.
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1::VideoSegment]
        #     Video segment where a text snippet was detected.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Confidence for the track of detected text. It is calculated as the highest
        #     over all frames where OCR detected text appears.
        # @!attribute [rw] frames
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::TextFrame>]
        #     Information related to the frames where OCR detected text appears.
        class TextSegment; end

        # Video frame level annotation results for text annotation (OCR).
        # Contains information regarding timestamp and bounding box locations for the
        # frames containing detected OCR text snippets.
        # @!attribute [rw] rotated_bounding_box
        #   @return [Google::Cloud::VideoIntelligence::V1::NormalizedBoundingPoly]
        #     Bounding polygon of the detected text for this frame.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     Timestamp of this frame.
        class TextFrame; end

        # Annotations related to one detected OCR text snippet. This will contain the
        # corresponding text, confidence value, and frame level information for each
        # detection.
        # @!attribute [rw] text
        #   @return [String]
        #     The detected text.
        # @!attribute [rw] segments
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::TextSegment>]
        #     All video segments where OCR detected text appears.
        class TextAnnotation; end

        # Video frame level annotations for object detection and tracking. This field
        # stores per frame location, time offset, and confidence.
        # @!attribute [rw] normalized_bounding_box
        #   @return [Google::Cloud::VideoIntelligence::V1::NormalizedBoundingBox]
        #     The normalized bounding box location of this object track for the frame.
        # @!attribute [rw] time_offset
        #   @return [Google::Protobuf::Duration]
        #     The timestamp of the frame in microseconds.
        class ObjectTrackingFrame; end

        # Annotations corresponding to one tracked object.
        # @!attribute [rw] segment
        #   @return [Google::Cloud::VideoIntelligence::V1::VideoSegment]
        #     Non-streaming batch mode ONLY.
        #     Each object track corresponds to one video segment where it appears.
        # @!attribute [rw] track_id
        #   @return [Integer]
        #     Streaming mode ONLY.
        #     In streaming mode, we do not know the end time of a tracked object
        #     before it is completed. Hence, there is no VideoSegment info returned.
        #     Instead, we provide a unique identifiable integer track_id so that
        #     the customers can correlate the results of the ongoing
        #     ObjectTrackAnnotation of the same track_id over time.
        # @!attribute [rw] entity
        #   @return [Google::Cloud::VideoIntelligence::V1::Entity]
        #     Entity to specify the object category that this track is labeled as.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     Object category's labeling confidence of this track.
        # @!attribute [rw] frames
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::ObjectTrackingFrame>]
        #     Information corresponding to all frames where this object track appears.
        #     Non-streaming batch mode: it may be one or multiple ObjectTrackingFrame
        #     messages in frames.
        #     Streaming mode: it can only be one ObjectTrackingFrame message in frames.
        class ObjectTrackingAnnotation; end

        # Annotation corresponding to one detected, tracked and recognized logo class.
        # @!attribute [rw] entity
        #   @return [Google::Cloud::VideoIntelligence::V1::Entity]
        #     Entity category information to specify the logo class that all the logo
        #     tracks within this LogoRecognitionAnnotation are recognized as.
        # @!attribute [rw] tracks
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::Track>]
        #     All logo tracks where the recognized logo appears. Each track corresponds
        #     to one logo instance appearing in consecutive frames.
        # @!attribute [rw] segments
        #   @return [Array<Google::Cloud::VideoIntelligence::V1::VideoSegment>]
        #     All video segments where the recognized logo appears. There might be
        #     multiple instances of the same logo class appearing in one VideoSegment.
        class LogoRecognitionAnnotation; end

        # Video annotation feature.
        module Feature
          # Unspecified.
          FEATURE_UNSPECIFIED = 0

          # Label detection. Detect objects, such as dog or flower.
          LABEL_DETECTION = 1

          # Shot change detection.
          SHOT_CHANGE_DETECTION = 2

          # Explicit content detection.
          EXPLICIT_CONTENT_DETECTION = 3

          # Human face detection and tracking.
          FACE_DETECTION = 4

          # Speech transcription.
          SPEECH_TRANSCRIPTION = 6

          # OCR text detection and tracking.
          TEXT_DETECTION = 7

          # Object detection and tracking.
          OBJECT_TRACKING = 9

          # Logo detection, tracking, and recognition.
          LOGO_RECOGNITION = 12
        end

        # Label detection mode.
        module LabelDetectionMode
          # Unspecified.
          LABEL_DETECTION_MODE_UNSPECIFIED = 0

          # Detect shot-level labels.
          SHOT_MODE = 1

          # Detect frame-level labels.
          FRAME_MODE = 2

          # Detect both shot-level and frame-level labels.
          SHOT_AND_FRAME_MODE = 3
        end

        # Bucketized representation of likelihood.
        module Likelihood
          # Unspecified likelihood.
          LIKELIHOOD_UNSPECIFIED = 0

          # Very unlikely.
          VERY_UNLIKELY = 1

          # Unlikely.
          UNLIKELY = 2

          # Possible.
          POSSIBLE = 3

          # Likely.
          LIKELY = 4

          # Very likely.
          VERY_LIKELY = 5
        end
      end
    end
  end
end