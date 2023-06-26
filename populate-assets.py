import random
import json
import requests
import time
from datetime import date


def get_any_one_item(list_items):
    """Returns a random item from the list."""
    return random.choice(list_items)


def get_arbitrary_items(list_items):
    """Returns a list of arbitrary items from the list."""
    num_items = random.randint(1, len(list_items))
    selected_items = set()
    for _ in range(num_items):
        selected_items.add(get_any_one_item(list_items))
    return list(selected_items)


def future_date():
    """Returns a random future date in DD/MM/YYYY format."""
    now = int(round(time.time()))
    random_future_epoch = now + 24 * 60 * 60 * random.randint(1, 365)
    return date.fromtimestamp(random_future_epoch).strftime('%d/%m/%Y')


def populate_to_db(json_payload):
    """Posts the JSON payload to the API Gateway endpoint."""
    apigw_url = 'https://ue0v2tz1p2.execute-api.ap-southeast-1.amazonaws.com/v1/assets'
    response = requests.post(apigw_url, headers={"Content-Type": "application/json"}, data=json.dumps(json_payload))
    if response.status_code != 201:
        print(response.json())
        raise Exception('Failed to post to API Gateway: {}'.format(response.status_code))


if __name__ == '__main__':
    count = 1
    for i in range(1, count + 1):
        asset_title = 'sample-asset-{}'.format(i)
        asset_description = 'sample asset {} description'.format(i)
        channels = get_arbitrary_items(['channel1', 'channel2', 'channel3'])
        created_by = 'author{}'.format(i)
        asset_type = get_any_one_item(['Audio', 'Document', 'Graphic/Visual', 'Photography', 'Video', '3D assets'])
        usage_rights = get_any_one_item(['Available', 'Confidential', 'On request', 'Licensed'])
        license_date_validity = future_date() if usage_rights == 'Licensed' else ''
        asset_categories = get_arbitrary_items(
            ['Brand Awareness', 'Customer Loyalty', 'New Customers', 'Product Launch', 'Sustainability',
             'DBS Foundation', 'DBS Sparks'])
        due_date = future_date()
        date_published = future_date()
        platforms = get_arbitrary_items(
            ['In-app', 'Live Events', 'Metaverse', 'Outdoor/Out-of-home', 'pWeb', 'Press/Media', 'Social'])
        campaigns = get_arbitrary_items(['campaign1', 'campaign2', 'campaign3'])
        priority = get_any_one_item(['Low', 'Medium', 'High'])
        markets = get_arbitrary_items(
            ['All', 'Singapore', 'Australia', 'Mainland China', 'Hong Kong', 'India', 'Indonesia', 'Japan', 'Korea',
             'Malaysia', 'Taiwan', 'Thailand', 'UAE', 'United Kingdom', 'Vietnam', 'Others'])
        tags = get_arbitrary_items(['tag1', 'tag2', 'tag3', 'tag4', 'tag5'])
        advanced_rights = get_arbitrary_items(['Show watermark', 'Archive'])
        asset_location = {
            'bucket': 'dbs-cmm',
            'key': '0c09853b-be48-4a4d-8eba-872dc212e900_abc.png'
        }
        preview_location = {
            'bucket': 'dbs-cmm',
            'key': 'visual-asset-management-system.png'
        }
        original_filename = 'sample_file.png'
        
        json_payload = {
            'assetTitle': asset_title,
            'assetDescription': asset_description,
            'channels': channels,
            'createdBy': created_by,
            'assetType': asset_type,
            'usageRights': usage_rights,
            'licenseDateValidity': license_date_validity,
            'assetCategories': asset_categories,
            'dueDate': due_date,
            'datePublished': date_published,
            'platforms': platforms,
            'campaigns': campaigns,
            'priority': priority,
            'markets': markets,
            'tags': tags,
            'advancedRights': advanced_rights,
            'assetLocation': asset_location,
            'previewLocation': preview_location,
            'originalFilename': original_filename
        }
        # print(json.dumps(json_payload, indent=1))
        populate_to_db(json_payload)
