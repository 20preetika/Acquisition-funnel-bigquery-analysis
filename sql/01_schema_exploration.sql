SELECT *
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
LIMIT 1;

SELECT
  visitId,
  h.hitNumber,
  h.type,
  h.eCommerceAction.action_type
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`,
UNNEST(hits) AS h
LIMIT 20;
