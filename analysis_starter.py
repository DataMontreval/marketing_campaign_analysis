# Starter analysis (Python / pandas)
import pandas as pd

df = pd.read_csv('marketing_campaign_data.csv', parse_dates=['event_date','signup_date'])

# Basic metrics by channel
channel = df.groupby('channel').agg({
    'impressions':'sum',
    'clicks':'sum',
    'conversions':'sum',
    'revenue':'sum',
    'cost':'sum'
}).reset_index()

channel['ctr'] = channel['clicks'] / channel['impressions']
channel['conversion_rate'] = channel['conversions'] / channel['clicks']
channel['cpa'] = channel['cost'] / channel['conversions']
channel['roi'] = (channel['revenue'] - channel['cost']) / channel['cost']

print(channel.sort_values('roi', ascending=False).to_string(index=False))

# Save outputs
channel.to_csv('channel_metrics_summary.csv', index=False)