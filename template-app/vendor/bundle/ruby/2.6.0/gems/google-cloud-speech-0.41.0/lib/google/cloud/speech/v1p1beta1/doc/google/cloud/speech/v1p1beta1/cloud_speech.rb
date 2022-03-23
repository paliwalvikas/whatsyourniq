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
    module Speech
      module V1p1beta1
        # The top-level message sent by the client for the `Recognize` method.
        # @!attribute [rw] config
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionConfig]
        #     Required. Provides information to the recognizer that specifies how to
        #     process the request.
        # @!attribute [rw] audio
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionAudio]
        #     Required. The audio data to be recognized.
        class RecognizeRequest; end

        # The top-level message sent by the client for the `LongRunningRecognize`
        # method.
        # @!attribute [rw] config
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionConfig]
        #     Required. Provides information to the recognizer that specifies how to
        #     process the request.
        # @!attribute [rw] audio
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionAudio]
        #     Required. The audio data to be recognized.
        class LongRunningRecognizeRequest; end

        # The top-level message sent by the client for the `StreamingRecognize` method.
        # Multiple `StreamingRecognizeRequest` messages are sent. The first message
        # must contain a `streaming_config` message and must not contain
        # `audio_content`. All subsequent messages must contain `audio_content` and
        # must not contain a `streaming_config` message.
        # @!attribute [rw] streaming_config
        #   @return [Google::Cloud::Speech::V1p1beta1::StreamingRecognitionConfig]
        #     Provides information to the recognizer that specifies how to process the
        #     request. The first `StreamingRecognizeRequest` message must contain a
        #     `streaming_config`  message.
        # @!attribute [rw] audio_content
        #   @return [String]
        #     The audio data to be recognized. Sequential chunks of audio data are sent
        #     in sequential `StreamingRecognizeRequest` messages. The first
        #     `StreamingRecognizeRequest` message must not contain `audio_content` data
        #     and all subsequent `StreamingRecognizeRequest` messages must contain
        #     `audio_content` data. The audio bytes must be encoded as specified in
        #     `RecognitionConfig`. Note: as with all bytes fields, proto buffers use a
        #     pure binary representation (not base64). See
        #     [content limits](https://cloud.google.com/speech-to-text/quotas#content).
        class StreamingRecognizeRequest; end

        # Provides information to the recognizer that specifies how to process the
        # request.
        # @!attribute [rw] config
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionConfig]
        #     Required. Provides information to the recognizer that specifies how to
        #     process the request.
        # @!attribute [rw] single_utterance
        #   @return [true, false]
        #     If `false` or omitted, the recognizer will perform continuous
        #     recognition (continuing to wait for and process audio even if the user
        #     pauses speaking) until the client closes the input stream (gRPC API) or
        #     until the maximum time limit has been reached. May return multiple
        #     `StreamingRecognitionResult`s with the `is_final` flag set to `true`.
        #
        #     If `true`, the recognizer will detect a single spoken utterance. When it
        #     detects that the user has paused or stopped speaking, it will return an
        #     `END_OF_SINGLE_UTTERANCE` event and cease recognition. It will return no
        #     more than one `StreamingRecognitionResult` with the `is_final` flag set to
        #     `true`.
        # @!attribute [rw] interim_results
        #   @return [true, false]
        #     If `true`, interim results (tentative hypotheses) may be
        #     returned as they become available (these interim results are indicated with
        #     the `is_final=false` flag).
        #     If `false` or omitted, only `is_final=true` result(s) are returned.
        class StreamingRecognitionConfig; end

        # Provides information to the recognizer that specifies how to process the
        # request.
        # @!attribute [rw] encoding
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionConfig::AudioEncoding]
        #     Encoding of audio data sent in all `RecognitionAudio` messages.
        #     This field is optional for `FLAC` and `WAV` audio files and required
        #     for all other audio formats. For details, see {Google::Cloud::Speech::V1p1beta1::RecognitionConfig::AudioEncoding AudioEncoding}.
        # @!attribute [rw] sample_rate_hertz
        #   @return [Integer]
        #     Sample rate in Hertz of the audio data sent in all
        #     `RecognitionAudio` messages. Valid values are: 8000-48000.
        #     16000 is optimal. For best results, set the sampling rate of the audio
        #     source to 16000 Hz. If that's not possible, use the native sample rate of
        #     the audio source (instead of re-sampling).
        #     This field is optional for FLAC and WAV audio files, but is
        #     required for all other audio formats. For details, see {Google::Cloud::Speech::V1p1beta1::RecognitionConfig::AudioEncoding AudioEncoding}.
        # @!attribute [rw] audio_channel_count
        #   @return [Integer]
        #     The number of channels in the input audio data.
        #     ONLY set this for MULTI-CHANNEL recognition.
        #     Valid values for LINEAR16 and FLAC are `1`-`8`.
        #     Valid values for OGG_OPUS are '1'-'254'.
        #     Valid value for MULAW, AMR, AMR_WB and SPEEX_WITH_HEADER_BYTE is only `1`.
        #     If `0` or omitted, defaults to one channel (mono).
        #     Note: We only recognize the first channel by default.
        #     To perform independent recognition on each channel set
        #     `enable_separate_recognition_per_channel` to 'true'.
        # @!attribute [rw] enable_separate_recognition_per_channel
        #   @return [true, false]
        #     This needs to be set to `true` explicitly and `audio_channel_count` > 1
        #     to get each channel recognized separately. The recognition result will
        #     contain a `channel_tag` field to state which channel that result belongs
        #     to. If this is not true, we will only recognize the first channel. The
        #     request is billed cumulatively for all channels recognized:
        #     `audio_channel_count` multiplied by the length of the audio.
        # @!attribute [rw] language_code
        #   @return [String]
        #     Required. The language of the supplied audio as a
        #     [BCP-47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) language tag.
        #     Example: "en-US".
        #     See [Language
        #     Support](https://cloud.google.com/speech-to-text/docs/languages) for a list
        #     of the currently supported language codes.
        # @!attribute [rw] alternative_language_codes
        #   @return [Array<String>]
        #     A list of up to 3 additional
        #     [BCP-47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) language tags,
        #     listing possible alternative languages of the supplied audio.
        #     See [Language
        #     Support](https://cloud.google.com/speech-to-text/docs/languages) for a list
        #     of the currently supported language codes. If alternative languages are
        #     listed, recognition result will contain recognition in the most likely
        #     language detected including the main language_code. The recognition result
        #     will include the language tag of the language detected in the audio. Note:
        #     This feature is only supported for Voice Command and Voice Search use cases
        #     and performance may vary for other use cases (e.g., phone call
        #     transcription).
        # @!attribute [rw] max_alternatives
        #   @return [Integer]
        #     Maximum number of recognition hypotheses to be returned.
        #     Specifically, the maximum number of `SpeechRecognitionAlternative` messages
        #     within each `SpeechRecognitionResult`.
        #     The server may return fewer than `max_alternatives`.
        #     Valid values are `0`-`30`. A value of `0` or `1` will return a maximum of
        #     one. If omitted, will return a maximum of one.
        # @!attribute [rw] profanity_filter
        #   @return [true, false]
        #     If set to `true`, the server will attempt to filter out
        #     profanities, replacing all but the initial character in each filtered word
        #     with asterisks, e.g. "f***". If set to `false` or omitted, profanities
        #     won't be filtered out.
        # @!attribute [rw] speech_contexts
        #   @return [Array<Google::Cloud::Speech::V1p1beta1::SpeechContext>]
        #     Array of {Google::Cloud::Speech::V1p1beta1::SpeechContext SpeechContext}.
        #     A means to provide context to assist the speech recognition. For more
        #     information, see
        #     [speech
        #     adaptation](https://cloud.google.com/speech-to-text/docs/context-strength).
        # @!attribute [rw] enable_word_time_offsets
        #   @return [true, false]
        #     If `true`, the top result includes a list of words and
        #     the start and end time offsets (timestamps) for those words. If
        #     `false`, no word-level time offset information is returned. The default is
        #     `false`.
        # @!attribute [rw] enable_word_confidence
        #   @return [true, false]
        #     If `true`, the top result includes a list of words and the
        #     confidence for those words. If `false`, no word-level confidence
        #     information is returned. The default is `false`.
        # @!attribute [rw] enable_automatic_punctuation
        #   @return [true, false]
        #     If 'true', adds punctuation to recognition result hypotheses.
        #     This feature is only available in select languages. Setting this for
        #     requests in other languages has no effect at all.
        #     The default 'false' value does not add punctuation to result hypotheses.
        #     Note: This is currently offered as an experimental service, complimentary
        #     to all users. In the future this may be exclusively available as a
        #     premium feature.
        # @!attribute [rw] enable_speaker_diarization
        #   @return [true, false]
        #     If 'true', enables speaker detection for each recognized word in
        #     the top alternative of the recognition result using a speaker_tag provided
        #     in the WordInfo.
        #     Note: Use diarization_config instead.
        # @!attribute [rw] diarization_speaker_count
        #   @return [Integer]
        #     If set, specifies the estimated number of speakers in the conversation.
        #     Defaults to '2'. Ignored unless enable_speaker_diarization is set to true.
        #     Note: Use diarization_config instead.
        # @!attribute [rw] diarization_config
        #   @return [Google::Cloud::Speech::V1p1beta1::SpeakerDiarizationConfig]
        #     Config to enable speaker diarization and set additional
        #     parameters to make diarization better suited for your application.
        #     Note: When this is enabled, we send all the words from the beginning of the
        #     audio for the top alternative in every consecutive STREAMING responses.
        #     This is done in order to improve our speaker tags as our models learn to
        #     identify the speakers in the conversation over time.
        #     For non-streaming requests, the diarization results will be provided only
        #     in the top alternative of the FINAL SpeechRecognitionResult.
        # @!attribute [rw] metadata
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionMetadata]
        #     Metadata regarding this request.
        # @!attribute [rw] model
        #   @return [String]
        #     Which model to select for the given request. Select the model
        #     best suited to your domain to get best results. If a model is not
        #     explicitly specified, then we auto-select a model based on the parameters
        #     in the RecognitionConfig.
        #     <table>
        #       <tr>
        #         <td><b>Model</b></td>
        #         <td><b>Description</b></td>
        #       </tr>
        #       <tr>
        #         <td><code>command_and_search</code></td>
        #         <td>Best for short queries such as voice commands or voice search.</td>
        #       </tr>
        #       <tr>
        #         <td><code>phone_call</code></td>
        #         <td>Best for audio that originated from a phone call (typically
        #         recorded at an 8khz sampling rate).</td>
        #       </tr>
        #       <tr>
        #         <td><code>video</code></td>
        #         <td>Best for audio that originated from from video or includes multiple
        #             speakers. Ideally the audio is recorded at a 16khz or greater
        #             sampling rate. This is a premium model that costs more than the
        #             standard rate.</td>
        #       </tr>
        #       <tr>
        #         <td><code>default</code></td>
        #         <td>Best for audio that is not one of the specific audio models.
        #             For example, long-form audio. Ideally the audio is high-fidelity,
        #             recorded at a 16khz or greater sampling rate.</td>
        #       </tr>
        #     </table>
        # @!attribute [rw] use_enhanced
        #   @return [true, false]
        #     Set to true to use an enhanced model for speech recognition.
        #     If `use_enhanced` is set to true and the `model` field is not set, then
        #     an appropriate enhanced model is chosen if an enhanced model exists for
        #     the audio.
        #
        #     If `use_enhanced` is true and an enhanced version of the specified model
        #     does not exist, then the speech is recognized using the standard version
        #     of the specified model.
        class RecognitionConfig
          # The encoding of the audio data sent in the request.
          #
          # All encodings support only 1 channel (mono) audio, unless the
          # `audio_channel_count` and `enable_separate_recognition_per_channel` fields
          # are set.
          #
          # For best results, the audio source should be captured and transmitted using
          # a lossless encoding (`FLAC` or `LINEAR16`). The accuracy of the speech
          # recognition can be reduced if lossy codecs are used to capture or transmit
          # audio, particularly if background noise is present. Lossy codecs include
          # `MULAW`, `AMR`, `AMR_WB`, `OGG_OPUS`, `SPEEX_WITH_HEADER_BYTE`, and `MP3`.
          #
          # The `FLAC` and `WAV` audio file formats include a header that describes the
          # included audio content. You can request recognition for `WAV` files that
          # contain either `LINEAR16` or `MULAW` encoded audio.
          # If you send `FLAC` or `WAV` audio file format in
          # your request, you do not need to specify an `AudioEncoding`; the audio
          # encoding format is determined from the file header. If you specify
          # an `AudioEncoding` when you send  send `FLAC` or `WAV` audio, the
          # encoding configuration must match the encoding described in the audio
          # header; otherwise the request returns an
          # {Google::Rpc::Code::INVALID_ARGUMENT} error code.
          module AudioEncoding
            # Not specified.
            ENCODING_UNSPECIFIED = 0

            # Uncompressed 16-bit signed little-endian samples (Linear PCM).
            LINEAR16 = 1

            # `FLAC` (Free Lossless Audio
            # Codec) is the recommended encoding because it is
            # lossless--therefore recognition is not compromised--and
            # requires only about half the bandwidth of `LINEAR16`. `FLAC` stream
            # encoding supports 16-bit and 24-bit samples, however, not all fields in
            # `STREAMINFO` are supported.
            FLAC = 2

            # 8-bit samples that compand 14-bit audio samples using G.711 PCMU/mu-law.
            MULAW = 3

            # Adaptive Multi-Rate Narrowband codec. `sample_rate_hertz` must be 8000.
            AMR = 4

            # Adaptive Multi-Rate Wideband codec. `sample_rate_hertz` must be 16000.
            AMR_WB = 5

            # Opus encoded audio frames in Ogg container
            # ([OggOpus](https://wiki.xiph.org/OggOpus)).
            # `sample_rate_hertz` must be one of 8000, 12000, 16000, 24000, or 48000.
            OGG_OPUS = 6

            # Although the use of lossy encodings is not recommended, if a very low
            # bitrate encoding is required, `OGG_OPUS` is highly preferred over
            # Speex encoding. The [Speex](https://speex.org/)  encoding supported by
            # Cloud Speech API has a header byte in each block, as in MIME type
            # `audio/x-speex-with-header-byte`.
            # It is a variant of the RTP Speex encoding defined in
            # [RFC 5574](https://tools.ietf.org/html/rfc5574).
            # The stream is a sequence of blocks, one block per RTP packet. Each block
            # starts with a byte containing the length of the block, in bytes, followed
            # by one or more frames of Speex data, padded to an integral number of
            # bytes (octets) as specified in RFC 5574. In other words, each RTP header
            # is replaced with a single byte containing the block length. Only Speex
            # wideband is supported. `sample_rate_hertz` must be 16000.
            SPEEX_WITH_HEADER_BYTE = 7

            # MP3 audio. Support all standard MP3 bitrates (which range from 32-320
            # kbps). When using this encoding, `sample_rate_hertz` can be optionally
            # unset if not known.
            MP3 = 8
          end
        end

        # Config to enable speaker diarization.
        # @!attribute [rw] enable_speaker_diarization
        #   @return [true, false]
        #     If 'true', enables speaker detection for each recognized word in
        #     the top alternative of the recognition result using a speaker_tag provided
        #     in the WordInfo.
        # @!attribute [rw] min_speaker_count
        #   @return [Integer]
        #     Minimum number of speakers in the conversation. This range gives you more
        #     flexibility by allowing the system to automatically determine the correct
        #     number of speakers. If not set, the default value is 2.
        # @!attribute [rw] max_speaker_count
        #   @return [Integer]
        #     Maximum number of speakers in the conversation. This range gives you more
        #     flexibility by allowing the system to automatically determine the correct
        #     number of speakers. If not set, the default value is 6.
        class SpeakerDiarizationConfig; end

        # Description of audio data to be recognized.
        # @!attribute [rw] interaction_type
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionMetadata::InteractionType]
        #     The use case most closely describing the audio content to be recognized.
        # @!attribute [rw] industry_naics_code_of_audio
        #   @return [Integer]
        #     The industry vertical to which this speech recognition request most
        #     closely applies. This is most indicative of the topics contained
        #     in the audio.  Use the 6-digit NAICS code to identify the industry
        #     vertical - see https://www.naics.com/search/.
        # @!attribute [rw] microphone_distance
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionMetadata::MicrophoneDistance]
        #     The audio type that most closely describes the audio being recognized.
        # @!attribute [rw] original_media_type
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionMetadata::OriginalMediaType]
        #     The original media the speech was recorded on.
        # @!attribute [rw] recording_device_type
        #   @return [Google::Cloud::Speech::V1p1beta1::RecognitionMetadata::RecordingDeviceType]
        #     The type of device the speech was recorded with.
        # @!attribute [rw] recording_device_name
        #   @return [String]
        #     The device used to make the recording.  Examples 'Nexus 5X' or
        #     'Polycom SoundStation IP 6000' or 'POTS' or 'VoIP' or
        #     'Cardioid Microphone'.
        # @!attribute [rw] original_mime_type
        #   @return [String]
        #     Mime type of the original audio file.  For example `audio/m4a`,
        #     `audio/x-alaw-basic`, `audio/mp3`, `audio/3gpp`.
        #     A list of possible audio mime types is maintained at
        #     http://www.iana.org/assignments/media-types/media-types.xhtml#audio
        # @!attribute [rw] obfuscated_id
        #   @return [Integer]
        #     Obfuscated (privacy-protected) ID of the user, to identify number of
        #     unique users using the service.
        # @!attribute [rw] audio_topic
        #   @return [String]
        #     Description of the content. Eg. "Recordings of federal supreme court
        #     hearings from 2012".
        class RecognitionMetadata
          # Use case categories that the audio recognition request can be described
          # by.
          module InteractionType
            # Use case is either unknown or is something other than one of the other
            # values below.
            INTERACTION_TYPE_UNSPECIFIED = 0

            # Multiple people in a conversation or discussion. For example in a
            # meeting with two or more people actively participating. Typically
            # all the primary people speaking would be in the same room (if not,
            # see PHONE_CALL)
            DISCUSSION = 1

            # One or more persons lecturing or presenting to others, mostly
            # uninterrupted.
            PRESENTATION = 2

            # A phone-call or video-conference in which two or more people, who are
            # not in the same room, are actively participating.
            PHONE_CALL = 3

            # A recorded message intended for another person to listen to.
            VOICEMAIL = 4

            # Professionally produced audio (eg. TV Show, Podcast).
            PROFESSIONALLY_PRODUCED = 5

            # Transcribe spoken questions and queries into text.
            VOICE_SEARCH = 6

            # Transcribe voice commands, such as for controlling a device.
            VOICE_COMMAND = 7

            # Transcribe speech to text to create a written document, such as a
            # text-message, email or report.
            DICTATION = 8
          end

          # Enumerates the types of capture settings describing an audio file.
          module MicrophoneDistance
            # Audio type is not known.
            MICROPHONE_DISTANCE_UNSPECIFIED = 0

            # The audio was captured from a closely placed microphone. Eg. phone,
            # dictaphone, or handheld microphone. Generally if there speaker is within
            # 1 meter of the microphone.
            NEARFIELD = 1

            # The speaker if within 3 meters of the microphone.
            MIDFIELD = 2

            # The speaker is more than 3 meters away from the microphone.
            FARFIELD = 3
          end

          # The original media the speech was recorded on.
          module OriginalMediaType
            # Unknown original media type.
            ORIGINAL_MEDIA_TYPE_UNSPECIFIED = 0

            # The speech data is an audio recording.
            AUDIO = 1

            # The speech data originally recorded on a video.
            VIDEO = 2
          end

          # The type of device the speech was recorded with.
          module RecordingDeviceType
            # The recording device is unknown.
            RECORDING_DEVICE_TYPE_UNSPECIFIED = 0

            # Speech was recorded on a smartphone.
            SMARTPHONE = 1

            # Speech was recorded using a personal computer or tablet.
            PC = 2

            # Speech was recorded over a phone line.
            PHONE_LINE = 3

            # Speech was recorded in a vehicle.
            VEHICLE = 4

            # Speech was recorded outdoors.
            OTHER_OUTDOOR_DEVICE = 5

            # Speech was recorded indoors.
            OTHER_INDOOR_DEVICE = 6
          end
        end

        # Provides "hints" to the speech recognizer to favor specific words and phrases
        # in the results.
        # @!attribute [rw] phrases
        #   @return [Array<String>]
        #     A list of strings containing words and phrases "hints" so that
        #     the speech recognition is more likely to recognize them. This can be used
        #     to improve the accuracy for specific words and phrases, for example, if
        #     specific commands are typically spoken by the user. This can also be used
        #     to add additional words to the vocabulary of the recognizer. See
        #     [usage limits](https://cloud.google.com/speech-to-text/quotas#content).
        #
        #     List items can also be set to classes for groups of words that represent
        #     common concepts that occur in natural language. For example, rather than
        #     providing phrase hints for every month of the year, using the $MONTH class
        #     improves the likelihood of correctly transcribing audio that includes
        #     months.
        # @!attribute [rw] boost
        #   @return [Float]
        #     Hint Boost. Positive value will increase the probability that a specific
        #     phrase will be recognized over other similar sounding phrases. The higher
        #     the boost, the higher the chance of false positive recognition as well.
        #     Negative boost values would correspond to anti-biasing. Anti-biasing is not
        #     enabled, so negative boost will simply be ignored. Though `boost` can
        #     accept a wide range of positive values, most use cases are best served with
        #     values between 0 and 20. We recommend using a binary search approach to
        #     finding the optimal value for your use case.
        class SpeechContext; end

        # Contains audio data in the encoding specified in the `RecognitionConfig`.
        # Either `content` or `uri` must be supplied. Supplying both or neither
        # returns {Google::Rpc::Code::INVALID_ARGUMENT}. See
        # [content limits](https://cloud.google.com/speech-to-text/quotas#content).
        # @!attribute [rw] content
        #   @return [String]
        #     The audio data bytes encoded as specified in
        #     `RecognitionConfig`. Note: as with all bytes fields, proto buffers use a
        #     pure binary representation, whereas JSON representations use base64.
        # @!attribute [rw] uri
        #   @return [String]
        #     URI that points to a file that contains audio data bytes as specified in
        #     `RecognitionConfig`. The file must not be compressed (for example, gzip).
        #     Currently, only Google Cloud Storage URIs are
        #     supported, which must be specified in the following format:
        #     `gs://bucket_name/object_name` (other URI formats return
        #     {Google::Rpc::Code::INVALID_ARGUMENT}). For more information, see
        #     [Request URIs](https://cloud.google.com/storage/docs/reference-uris).
        class RecognitionAudio; end

        # The only message returned to the client by the `Recognize` method. It
        # contains the result as zero or more sequential `SpeechRecognitionResult`
        # messages.
        # @!attribute [rw] results
        #   @return [Array<Google::Cloud::Speech::V1p1beta1::SpeechRecognitionResult>]
        #     Sequential list of transcription results corresponding to
        #     sequential portions of audio.
        class RecognizeResponse; end

        # The only message returned to the client by the `LongRunningRecognize` method.
        # It contains the result as zero or more sequential `SpeechRecognitionResult`
        # messages. It is included in the `result.response` field of the `Operation`
        # returned by the `GetOperation` call of the `google::longrunning::Operations`
        # service.
        # @!attribute [rw] results
        #   @return [Array<Google::Cloud::Speech::V1p1beta1::SpeechRecognitionResult>]
        #     Sequential list of transcription results corresponding to
        #     sequential portions of audio.
        class LongRunningRecognizeResponse; end

        # Describes the progress of a long-running `LongRunningRecognize` call. It is
        # included in the `metadata` field of the `Operation` returned by the
        # `GetOperation` call of the `google::longrunning::Operations` service.
        # @!attribute [rw] progress_percent
        #   @return [Integer]
        #     Approximate percentage of audio processed thus far. Guaranteed to be 100
        #     when the audio is fully processed and the results are available.
        # @!attribute [rw] start_time
        #   @return [Google::Protobuf::Timestamp]
        #     Time when the request was received.
        # @!attribute [rw] last_update_time
        #   @return [Google::Protobuf::Timestamp]
        #     Time of the most recent processing update.
        class LongRunningRecognizeMetadata; end

        # `StreamingRecognizeResponse` is the only message returned to the client by
        # `StreamingRecognize`. A series of zero or more `StreamingRecognizeResponse`
        # messages are streamed back to the client. If there is no recognizable
        # audio, and `single_utterance` is set to false, then no messages are streamed
        # back to the client.
        #
        # Here's an example of a series of ten `StreamingRecognizeResponse`s that might
        # be returned while processing audio:
        #
        # 1. results { alternatives { transcript: "tube" } stability: 0.01 }
        #
        # 2. results { alternatives { transcript: "to be a" } stability: 0.01 }
        #
        # 3. results { alternatives { transcript: "to be" } stability: 0.9 }
        #    results { alternatives { transcript: " or not to be" } stability: 0.01 }
        #
        # 4. results { alternatives { transcript: "to be or not to be"
        #                             confidence: 0.92 }
        #              alternatives { transcript: "to bee or not to bee" }
        #              is_final: true }
        #
        # 5. results { alternatives { transcript: " that's" } stability: 0.01 }
        #
        # 6. results { alternatives { transcript: " that is" } stability: 0.9 }
        #    results { alternatives { transcript: " the question" } stability: 0.01 }
        #
        # 7. results { alternatives { transcript: " that is the question"
        #                             confidence: 0.98 }
        #              alternatives { transcript: " that was the question" }
        #              is_final: true }
        #
        # Notes:
        #
        # * Only two of the above responses #4 and #7 contain final results; they are
        #   indicated by `is_final: true`. Concatenating these together generates the
        #   full transcript: "to be or not to be that is the question".
        #
        # * The others contain interim `results`. #3 and #6 contain two interim
        #   `results`: the first portion has a high stability and is less likely to
        #   change; the second portion has a low stability and is very likely to
        #   change. A UI designer might choose to show only high stability `results`.
        #
        # * The specific `stability` and `confidence` values shown above are only for
        #   illustrative purposes. Actual values may vary.
        #
        # * In each response, only one of these fields will be set:
        #   `error`,
        #   `speech_event_type`, or
        #   one or more (repeated) `results`.
        # @!attribute [rw] error
        #   @return [Google::Rpc::Status]
        #     If set, returns a {Google::Rpc::Status} message that
        #     specifies the error for the operation.
        # @!attribute [rw] results
        #   @return [Array<Google::Cloud::Speech::V1p1beta1::StreamingRecognitionResult>]
        #     This repeated list contains zero or more results that
        #     correspond to consecutive portions of the audio currently being processed.
        #     It contains zero or one `is_final=true` result (the newly settled portion),
        #     followed by zero or more `is_final=false` results (the interim results).
        # @!attribute [rw] speech_event_type
        #   @return [Google::Cloud::Speech::V1p1beta1::StreamingRecognizeResponse::SpeechEventType]
        #     Indicates the type of speech event.
        class StreamingRecognizeResponse
          # Indicates the type of speech event.
          module SpeechEventType
            # No speech event specified.
            SPEECH_EVENT_UNSPECIFIED = 0

            # This event indicates that the server has detected the end of the user's
            # speech utterance and expects no additional speech. Therefore, the server
            # will not process additional audio (although it may subsequently return
            # additional results). The client should stop sending additional audio
            # data, half-close the gRPC connection, and wait for any additional results
            # until the server closes the gRPC connection. This event is only sent if
            # `single_utterance` was set to `true`, and is not used otherwise.
            END_OF_SINGLE_UTTERANCE = 1
          end
        end

        # A streaming speech recognition result corresponding to a portion of the audio
        # that is currently being processed.
        # @!attribute [rw] alternatives
        #   @return [Array<Google::Cloud::Speech::V1p1beta1::SpeechRecognitionAlternative>]
        #     May contain one or more recognition hypotheses (up to the
        #     maximum specified in `max_alternatives`).
        #     These alternatives are ordered in terms of accuracy, with the top (first)
        #     alternative being the most probable, as ranked by the recognizer.
        # @!attribute [rw] is_final
        #   @return [true, false]
        #     If `false`, this `StreamingRecognitionResult` represents an
        #     interim result that may change. If `true`, this is the final time the
        #     speech service will return this particular `StreamingRecognitionResult`,
        #     the recognizer will not return any further hypotheses for this portion of
        #     the transcript and corresponding audio.
        # @!attribute [rw] stability
        #   @return [Float]
        #     An estimate of the likelihood that the recognizer will not
        #     change its guess about this interim result. Values range from 0.0
        #     (completely unstable) to 1.0 (completely stable).
        #     This field is only provided for interim results (`is_final=false`).
        #     The default of 0.0 is a sentinel value indicating `stability` was not set.
        # @!attribute [rw] result_end_time
        #   @return [Google::Protobuf::Duration]
        #     Time offset of the end of this result relative to the
        #     beginning of the audio.
        # @!attribute [rw] channel_tag
        #   @return [Integer]
        #     For multi-channel audio, this is the channel number corresponding to the
        #     recognized result for the audio from that channel.
        #     For audio_channel_count = N, its output values can range from '1' to 'N'.
        # @!attribute [rw] language_code
        #   @return [String]
        #     The [BCP-47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) language tag
        #     of the language in this result. This language code was detected to have
        #     the most likelihood of being spoken in the audio.
        class StreamingRecognitionResult; end

        # A speech recognition result corresponding to a portion of the audio.
        # @!attribute [rw] alternatives
        #   @return [Array<Google::Cloud::Speech::V1p1beta1::SpeechRecognitionAlternative>]
        #     May contain one or more recognition hypotheses (up to the
        #     maximum specified in `max_alternatives`).
        #     These alternatives are ordered in terms of accuracy, with the top (first)
        #     alternative being the most probable, as ranked by the recognizer.
        # @!attribute [rw] channel_tag
        #   @return [Integer]
        #     For multi-channel audio, this is the channel number corresponding to the
        #     recognized result for the audio from that channel.
        #     For audio_channel_count = N, its output values can range from '1' to 'N'.
        # @!attribute [rw] language_code
        #   @return [String]
        #     The [BCP-47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) language tag
        #     of the language in this result. This language code was detected to have
        #     the most likelihood of being spoken in the audio.
        class SpeechRecognitionResult; end

        # Alternative hypotheses (a.k.a. n-best list).
        # @!attribute [rw] transcript
        #   @return [String]
        #     Transcript text representing the words that the user spoke.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     The confidence estimate between 0.0 and 1.0. A higher number
        #     indicates an estimated greater likelihood that the recognized words are
        #     correct. This field is set only for the top alternative of a non-streaming
        #     result or, of a streaming result where `is_final=true`.
        #     This field is not guaranteed to be accurate and users should not rely on it
        #     to be always provided.
        #     The default of 0.0 is a sentinel value indicating `confidence` was not set.
        # @!attribute [rw] words
        #   @return [Array<Google::Cloud::Speech::V1p1beta1::WordInfo>]
        #     A list of word-specific information for each recognized word.
        #     Note: When `enable_speaker_diarization` is true, you will see all the words
        #     from the beginning of the audio.
        class SpeechRecognitionAlternative; end

        # Word-specific information for recognized words.
        # @!attribute [rw] start_time
        #   @return [Google::Protobuf::Duration]
        #     Time offset relative to the beginning of the audio,
        #     and corresponding to the start of the spoken word.
        #     This field is only set if `enable_word_time_offsets=true` and only
        #     in the top hypothesis.
        #     This is an experimental feature and the accuracy of the time offset can
        #     vary.
        # @!attribute [rw] end_time
        #   @return [Google::Protobuf::Duration]
        #     Time offset relative to the beginning of the audio,
        #     and corresponding to the end of the spoken word.
        #     This field is only set if `enable_word_time_offsets=true` and only
        #     in the top hypothesis.
        #     This is an experimental feature and the accuracy of the time offset can
        #     vary.
        # @!attribute [rw] word
        #   @return [String]
        #     The word corresponding to this set of information.
        # @!attribute [rw] confidence
        #   @return [Float]
        #     The confidence estimate between 0.0 and 1.0. A higher number
        #     indicates an estimated greater likelihood that the recognized words are
        #     correct. This field is set only for the top alternative of a non-streaming
        #     result or, of a streaming result where `is_final=true`.
        #     This field is not guaranteed to be accurate and users should not rely on it
        #     to be always provided.
        #     The default of 0.0 is a sentinel value indicating `confidence` was not set.
        # @!attribute [rw] speaker_tag
        #   @return [Integer]
        #     A distinct integer value is assigned for every speaker within
        #     the audio. This field specifies which one of those speakers was detected to
        #     have spoken this word. Value ranges from '1' to diarization_speaker_count.
        #     speaker_tag is set if enable_speaker_diarization = 'true' and only in the
        #     top alternative.
        class WordInfo; end
      end
    end
  end
end