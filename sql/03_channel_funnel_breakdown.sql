SELECT
  channelGrouping,
  COUNTIF(h.eCommerceAction.action_type = '2') AS product_views,
  COUNTIF(h.eCommerceAction.action_type = '3') AS add_to_carts,
  COUNTIF(h.eCommerceAction.action_type = '5') AS checkouts,
  COUNTIF(h.eCommerceAction.action_type = '6') AS purchases
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
UNNEST(hits) AS h
WHERE _TABLE_SUFFIX BETWEEN '20170801' AND '20170831'
GROUP BY channelGrouping
ORDER BY product_views DESC;
