Sentry.init do |config|
  config.dsn = 'https://12a2d39b955948beb99e240bb3b758ac@o225165.ingest.sentry.io/5199199'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 0.5
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
