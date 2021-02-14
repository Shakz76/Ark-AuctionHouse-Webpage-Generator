# Ark-AuctionHouse-Webpage-Generator
Generate a web page based on the API call to the Ark Auction House mod by [Ghazlawl](https://linode.ghazlawl.com/)
This script runs in a windows environment. It will scrape data from the auction house and display it in an HTML table.


**EXAMPLE**:http://eazyhax.com/auctionhouse/


**The Main Benifit:** The website is VASTLY faster than using the in game interface. This will allow your users to quickly browse the market. On my server we can only interact with the market via a single server hub. This means we have to jump first to see what is available then jump back to get the asking price....etc.

I plan to add the ability for users to check their own market items based on SteamID if people end up using the script.

**Instructions:**
* Download and unzip the release "Source Code.zip"
* Replace [YOUR-MARKET-ID-HERE] with your market id
* Place the img file and the script in the directory you want the website to reside
* Run the script via a scheduled task or manually

You can of course run it locally first to test prior to deployment on your web server.  

**Known Issues:**

* I expect some item images may be missing and will update the img files as reports come in if possible.
* Dino Damage is calculated on the server based on settings so its not listed correctly
* Egg Parent levels are not provided by the API so they are missing

The first release is available [here](https://github.com/Shakz76/Ark-AuctionHouse-Webpage-Generator/releases)
