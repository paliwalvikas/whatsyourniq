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
  module Monitoring
    module Dashboard
      module V1
        # A widget that displays textual content.
        # @!attribute [rw] content
        #   @return [String]
        #     The text content to be displayed.
        # @!attribute [rw] format
        #   @return [Google::Monitoring::Dashboard::V1::Text::Format]
        #     How the text content is formatted.
        class Text
          # The format type of the text content.
          module Format
            # Format is unspecified. Defaults to MARKDOWN.
            FORMAT_UNSPECIFIED = 0

            # The text contains Markdown formatting.
            MARKDOWN = 1

            # The text contains no special formatting.
            RAW = 2
          end
        end
      end
    end
  end
end