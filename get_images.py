import os
from datetime import datetime, timedelta
import ast

import requests

# Dictionary of filenames and image URLs eg
# image_data = {
#     'Yiddish Shabbat Dinner': 'https://f6h6i8w5.stackpathcdn.com/wp-content/uploads/2021/08/Roman-Vishniac_htm_b310759afa874e25.jpg',
#     'Meditation with Ife': 'https://img.freepik.com/free-photo/one-hiking-lifestyle-summer-yoga_1150-1002.jpg?w=1380&t=st=1697602562~exp=1697603162~hmac=96e959b7c13dea684d33c1bf006a338a5ef32c397c319c9e6afbf6c12cc837db',
#     'Condux + Klezmer Concert': 'https://www.stringbassonline.com/images/unit6/klezmer_musicians.jpg',
#     'Improv with Ariella': 'https://api.brusselstimes.com/wp-content/uploads/2020/05/7o.jpg',
#     'Shabbat Afternoon Boardgames & Singing': 'https://cdn.thewirecutter.com/wp-content/media/2020/10/smallworldboardgames-2048px-33.jpg',
#     'Adah Yidish Song Workshop': 'https://cdn.britannica.com/59/131359-050-632F5841/Yiddish-alphabet.jpg',
# }

# image_data = ast.literal_eval(input("Enter the image data dict: "))
image_data = {
    '🍪 Cocoa, Cookies, Crafting': 'https://www.atlantaparent.com/wp-content/uploads/2020/11/iStock-866181908-1024x683.jpg',
    '🍸 Post-TBS-Potluck Tisch & Cocktails': 'https://mcusercontent.com/759d2cb486ebe9ef6e6654e15/images/c494b8ea-c020-fe18-c3ca-af091ddde313.png',
    '🏈 Football&Wings': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmgnWH6FtTiWnNqYAkYS25K6MLEj-0K8RXjw&s',
    '🍴📖 Bookworm Dinner': 'https://img.freepik.com/free-vector/hand-drawn-flat-design-stack-books-illustration_23-2149341898.jpg?semt=ais_hybrid',
    '🕯️💬🕯️Shabbat Dinner & Dialogue with Arab Israeli Changemakers': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToCx4GcSWuMZ1byZEfzWGIk9j1fsXcklowBA&s',
    "🎶 Rebecca Mac's Klezmer Variety Show": 'https://www.passim.org/wp-content/uploads/2023/02/Rebecca-MAc-2-scaled.jpg',
    '🍿 Cozy Movie Night': 'https://images.pexels.com/photos/9807277/pexels-photo-9807277.jpeg',
}
next_month = datetime.now() + timedelta(days=30)
download_folder = f"mailchimp/newsletters/{next_month.strftime('%Y_%m')}/{next_month.strftime('%B %Y')} images"

# Create the download folder if it doesn't exist
if not os.path.exists(download_folder):
    os.makedirs(download_folder)

# Loop through the dictionary of filenames and URLs and download the images
i = 0
for filename, img_url in image_data.items():
    i += 1
    # Get the image filename
    img_filename = os.path.join(download_folder, str(i) + ' ' + filename + '.jpg')

    # Send an HTTP GET request to the image URL
    img_response = requests.get(img_url)

    # Check if the request was successful
    if img_response.status_code == 200:
        # Save the image to the download folder
        with open(img_filename, 'wb') as img_file:
            img_file.write(img_response.content)
        print(f"Downloaded: {img_filename}")
    else:
        print(f"Failed to download: {img_url}")
