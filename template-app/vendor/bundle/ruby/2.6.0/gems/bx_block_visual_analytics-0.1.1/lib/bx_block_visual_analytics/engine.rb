# frozen_string_literal: true

module BxBlockVisualAnalytics
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockVisualAnalytics
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_visual_analytics.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockVisualAnalytics::Engine => base + '/visual_analytics'
      end
    end
  end
end
