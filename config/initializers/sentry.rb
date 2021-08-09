# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://e8bd9a43b666488db6bee4975626669d@o949860.ingest.sentry.io/5898547'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.traces_sample_rate = 0.5
end
