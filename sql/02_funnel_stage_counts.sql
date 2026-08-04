SELECT
  h.eCommerceAction.action_type,
  COUNT(*) AS hit_count
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
UNNEST(hits) AS h
WHERE _TABLE_SUFFIX BETWEEN '20170801' AND '20170831'
GROUP BY 1
ORDER BY 2 DESC;
