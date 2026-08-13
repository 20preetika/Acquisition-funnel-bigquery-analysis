# Acquisition Channel Funnel & Conversion Efficiency Analysis

## Why I built this
Every acquisition channel gets counted the same way in most reports - total sessions, total conversions. But that hides a lot. A channel bringing in 10x more traffic isn't automatically doing 10x more work if most of that traffic never converts. I wanted to actually break the funnel down by channel and see where people drop off, not just look at top-line numbers.

## Dataset
Used Google's public BigQuery dataset - `bigquery-public-data.google_analytics_sample`. It's real session-level data from the Google Merchandise Store (GA360), August 2017. Free to query in the BigQuery sandbox. Fields are nested - each session has an array of hits, each hit can have product data so this was also a good excuse to actually get comfortable with UNNEST instead of just reading about it.

## Tools
BigQuery SQL - UNNEST for the nested fields, COUNTIF for conditional aggregation. 
Repo on GitHub.

## What I did
1. First ran a plain SELECT * to understand the table structure before writing anything real.
2. Used UNNEST() to flatten the hits array so I could actually query it.
3. Counted hits by `eCommerceAction.action_type` to get the overall funnel shape - view, cart, checkout, purchase.
4. Ran the same breakdown again, this time split by `channelGrouping`, to compare channels against each other.

## What I found
Referral converts at 15.5% (view to purchase) about 6x higher than Organic Search at 2.5%. And Organic Search actually gets more product views than Referral. Referral alone drove 58 purchases , more than every other channel combined (34).

| Channel | Product Views | Add to Cart | Checkout | Purchases | View→Purchase % |
|---|---|---|---|---|---|
| Organic Search | 481 | 157 | 71 | 12 | 2.5% |
| Referral | 373 | 249 | 202 | 58 | 15.5% |
| Direct | 281 | 57 | 45 | 18 | 6.4% |
| Paid Search | 75 | 17 | 6 | 2 | 2.7% |
| Display | 13 | 11 | 5 | 2 | 15.4% |
| Social | 39 | 1 | 0 | 0 | 0% |
| Affiliates | 5 | 2 | 1 | 0 | 0% |

Social and Affiliates had under 40 views each, so their 0% doesn't mean much - just not enough volume to draw a conclusion.

The core point: more traffic doesn't mean better conversion. Organic Search brings the most eyeballs and converts the worst of the major channels. Referral does the opposite.

## What I'd actually recommend
Referral looks under-invested given how well it converts - worth pushing more into referral programs or partner links rather than just adding search budget.

Organic Search is the bigger question mark. High volume, weak conversion that usually points to a landing page or product-relevance problem, not a traffic problem. I'd want to look at that before spending more to bring in even more search traffic.

Paid Search converting about the same as Organic Search is worth a second look too, since that's direct spend. If this holds up over more than one month, it's worth checking CPC targeting.

## Files
- `sql/01_schema_exploration.sql`
- `sql/02_funnel_stage_counts.sql`
- `sql/03_channel_funnel_breakdown.sql`

## Limitations
Only one month of data (Aug 2017) - I would want to see this hold across a longer window before calling it a real trend. Also no actual marketing spend/cost data in this public dataset, so this measures conversion efficiency, not true ROI.
