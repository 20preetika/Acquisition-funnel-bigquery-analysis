# Acquisition Channel Funnel & Conversion Efficiency Analysis (BigQuery)

## Problem Statement
Marketing traffic comes in through several channels — organic search, paid search, referral, direct, social, and so on — but not all of it converts equally well. This project looks at session-level data to figure out which channels actually move users through the funnel efficiently (product view → cart → checkout → purchase), and where the biggest drop-offs happen.

Hypothesis going in: search channels (paid and organic) probably bring in more traffic volume but convert worse than direct or referral traffic.

## Dataset
Used BigQuery's public `bigquery-public-data.google_analytics_sample` dataset — this is real session-level e-commerce data from the Google Merchandise Store (GA360), covering August 2017. It's free to query in the BigQuery sandbox, no billing setup needed. The data has nested/repeated fields (each session has an array of hits, and each hit can have product-level data), tagged by `channelGrouping` and `eCommerceAction.action_type`.

## Tech Stack
- BigQuery (SQL) — mainly UNNEST for the nested fields, plus conditional aggregation with COUNTIF
- GitHub for the repo

## Approach
1. Started by exploring the schema — ran a basic SELECT * to see the structure, then used UNNEST() to flatten the hits array so I could actually work with it
2. Counted hits grouped by eCommerceAction.action_type to see the overall funnel shape (view → cart → checkout → purchase)
3. Ran the same funnel breakdown again, this time split by channelGrouping, to compare how each channel performs

## Key Finding
Referral traffic converts at about 15.5% (view to purchase) — roughly 6x higher than Organic Search, which converts at only 2.5%. This is despite Organic Search having more product views. Referral alone produced 58 purchases, more than every other channel combined (34).

| Channel | Product Views | Add to Cart | Checkout | Purchases | View→Purchase % |
|---|---|---|---|---|---|
| Organic Search | 481 | 157 | 71 | 12 | 2.5% |
| Referral | 373 | 249 | 202 | 58 | 15.5% |
| Direct | 281 | 57 | 45 | 18 | 6.4% |
| Paid Search | 75 | 17 | 6 | 2 | 2.7% |
| Display | 13 | 11 | 5 | 2 | 15.4% |
| Social | 39 | 1 | 0 | 0 | 0% |
| Affiliates | 5 | 2 | 1 | 0 | 0% |

Social and Affiliates barely have any volume (under 40 views each), so the 0% there isn't really a reliable signal — just not enough data to say anything meaningful about those two.

The main takeaway: more traffic doesn't mean better conversion. Organic Search brings in the most views but converts the worst among the major channels, while Referral does the opposite — fewer views, but far better at actually turning those views into purchases.

## What This Means for the Business
A few things stood out looking at this from a budget-allocation angle:

Referral seems under-leveraged. It's converting way better than search traffic, so there's a case for investing more in referral programs — partner links, affiliate-style referrals, customer referral incentives — rather than just pouring more budget into search.

Organic Search is a different story. It brings in the most people but converts the worst, which suggests the problem might not be traffic volume at all — it could be that the landing experience or product-page relevance isn't matching what people are searching for. Worth digging into before spending more to acquire even more search traffic.

Paid Search having a similar conversion rate to Organic Search is also worth flagging, since it's money being spent directly on that traffic. If this pattern holds up over more than one month, it's a reasonable candidate for a closer look at CPC spend and targeting.

## Files
- `sql/01_schema_exploration.sql` — initial look at the schema, nested fields
- `sql/02_funnel_stage_counts.sql` — overall funnel stage counts
- `sql/03_channel_funnel_breakdown.sql` — the main channel-level breakdown

## Limitations
This is one month of data (August 2017), so the pattern would need to hold across a longer window before treating it as a stable trend. Also, this public dataset doesn't include actual marketing spend or cost data, so this is measuring conversion efficiency, not a true ROI (revenue vs. cost) calculation.
