# Setup
1. Copy the [api key from mailchimp](https://mailchimp.com/help/about-api-keys/) as the whole body of [secrets.txt](secrets.txt)

If you're having issues with the app 
1. Run ` npm list` in the terminal. If it does not print ` markdown-to-mailchimp`, install [Markdown2Mailchimp](https://github.com/MarcL/markdown-to-mailchimp)
```bash
npm install markdown-to-mailchimp
```

# How it works 
The script, [prep_newsletter.sh](prep_newsletter.sh), will take a YAML frontmatter generated from the google sheet and a markdown file with the content of the newsletter and combine them into a single markdown file. This will then be slotted into a MJML template ([template.mjml](template.mjml)) that Markdown2Mailchimp turns into a HTML file and uploads to mailchimp.

# To Use
1. run `./prep_newsletter.sh` and follow the instructions, when it opens the files 
2. Copy in the YAML section from the google sheet into the frontmatter file
3. Edit the content of the newsletter
4. Hit save on both of them
5. Continue the sheet until it pushes to mailchimp 


# How to do everything for the month 
1. [ ] prep [**spreadsheet**](https://docs.google.com/spreadsheets/d/1qMnDVpDGI41fsvVe_E7hB-l5e4RHp6L9-Xs7VTlWc4A/edit?gid=1773043597#gid=1773043597)
    1. [ ] add any **forms** and **onetable**, making sure to put in the right dates
			**Onetable QS**  
				Vi bist du tsum yidish gekumen? (what got you interested in Yiddish)  
				Accomodations  
				Dietary
			**Jobs**  
				2 Set the table   
				3 Help make salads  
				2 Help clean up  
				1 Help serve food  
				2 Help wash dishes that can't go in the dishwasher  
    2. [ ] make sure all events have **images**
			an easy way to upload images is to go to [Campaign Builder - Template Designer | Mailchimp](https://us3.admin.mailchimp.com/campaigns/wizard/neapolitan?id=5555847) and drop all the images in and then you can click on them one by one to get the links (have to click replace to see the others, don't do the thumbnail it's smaller)  - seems like you can just drop it on the image in the newslette
1. [ ] **Facebook Events**
	- [ ] 1. download images using `get_images.py` with sv mailchimp - can just hit run the current file  
	- [ ] 2. copy the text at the top of the gsheet of all the facebook events (add it to template if not there)
	- [ ] 3. run [[Make All Facebook Events.scpt]]
	- [ ] 4. go through all tabs and click edit 
	- [ ] 5. upload all the pictures
	- [ ] 6. submit all
	- [ ] 7. click share on  all the tabs, and then go back through to copy the minified event link to the spreadsheet  
2. [ ] hit **generate calendar events**
3. [ ] **Newsletter**
	- [ ] 1. run the script on the gsheet
	- [ ] 2. run the script on pycharm fb project:  `sv mailchimp; cd mailchimp; ./prep_newsletter.sh `
			[YAML Checker - The YAML Syntax Validator](https://yamlchecker.com/)  
	- [ ] 3. check that it looks good  
	- [ ] ==if fewer than seven events, can change the HTML by editing the mailchimp==
	- [ ] 4. post the newsletter
4. [ ] **Whatsapp**
    1. [ ] read the messages to double check they look right and send times look right (eg days of week and ==shabbat times==)
    2. [ ] run script
        1. [ ] paste events into the top of the script `Whatsapp Event Scheduling Script`
        2. [ ] open [Beeper](https://chat.beeper.com/) web
        3. [ ] run script 
    3. [ ] double check the count
    4. send newsletter description on whatsapp - copy from the google sheet if it doesn't automatically input”
5. [ ] **request sync** for the website: [Customize Facebook Page Events](https://www.sociablekit.com/app/users/widgets/update_embed/25347017) login with  mohosomerville@gmail 
6. [ ] choose which **events to advertise at TBS** or the Camberville General WA group and schedule email with summaries of other events and website link
