#!/bin/bash

# Function to display text in different colors
#color_log() {
#  local color=$1
#  shift
#  echo -e "\e[${color}m$@\e[0m"
#}
#echo "$(color_log 31 "Proceeding...")"
#

script_dir="$(cd "$(dirname "$0")" && pwd)"

# Change to the script's directory
cd "$script_dir"


# Get the current year and month
current_year=$(date +'%Y')
current_month=$(date +'%m')

# Prompt user for the month number
read -p "Enter the number of the month you are making the newsletter for (1-12): " month
if [ -n "$answer" ] && { [ "$month" -lt 1 ] || [ "$month" -gt 12 ]; }; then
  echo "Invalid month number. Aborting."
  exit 1
elif [ -z "$month" ]; then
  ((month=current_month+1))
  read -p "No month number entered. Defaulting to next month ($month). Are you sure? (y/n): " answer
  if [ "$answer" = "n" ]; then
    read -p "Enter again the number of the month you are making the newsletter for (1-12): " month
  fi
fi
month=$(printf "%02d" "$month")

# Adjust year if the month is 1 and it is currently December
if [ "$current_month" -gt "$month" ]; then
  ((current_year++))
fi

# Create folder name in the format "month_year"
folder_name="newsletters/${current_year}_${month}"

# Create the folder
mkdir "$folder_name"

# Copy template.md to the folder and rename it to "month_year.md"
# Check if content file exists before copying
content_file="$folder_name/content_${current_year}_${month}.md"
if [ ! -e "$content_file" ]; then
  cp content_template.md "$content_file"
  echo "File '$content_file' created."
else
  echo "File '$content_file' already exists. Skipping copy operation."
fi
open "$content_file"

# Check if frontmatter file exists before creating}
frontmatter_file="$folder_name/frontmatter_${current_year}_${month}.md"
if [ ! -e "$frontmatter_file" ]; then
  touch "$frontmatter_file"
  echo "File '$frontmatter_file' created."
else
  echo "File '$frontmatter_file' already exists. Skipping creation."
fi
open "$frontmatter_file"

final_file="$folder_name/newsletter_${current_year}_${month}.md"

read -p "Are you ready to concatenate files? (y/n): " answer
if [ "$answer" = "y" ] || [ -z "$answer" ]; then
  if [ ! -s "$frontmatter_file" ]; then
    read -p "The frontmatter file is empty. Would you like to open it to edit it? (y/n): " answer_open
    if [ "$answer_open" = "y" ] || [ -z "$answer_open" ]; then
      open "$frontmatter_file"
    fi
    read -p "Do you want to try to concatenate files again? (y/n): " answer_concatenate_again
    if [ "$answer_concatenate_again" = "n" ]; then
      echo "Concatenation aborted."
      exit 1
    fi
    if [ ! -s "$frontmatter_file" ]; then
      echo "File still empty. Concatenation aborted."
      exit 1
    fi
  fi

  cat "$frontmatter_file" "$content_file" > "$final_file"
  echo "Files have been concatenated into '$final_file'."
else
  echo "Concatenation aborted."
fi


# Prompt user for generating HTML
read -p "Do you want to generate HTML? (y/n): " answer_generate_html
if [ "$answer_generate_html" = "y" ] || [ -z "$answer_generate_html" ]; then
  read -p "Do you want to push to Mailchimp? (y/n): " answer_push_mailchimp

  # Check if the user wants to push to Mailchimp
  if [ "$answer_push_mailchimp" = "y" ] || [ -z "$answer_push_mailchimp" ]; then
    # Read Mailchimp API key from secrets file
    # todo: turn secrets.text into a key value pair
    api_key=$(<secrets.txt)
    ./node_modules/.bin/md2mc -m $final_file -t template.mjml -o $folder_name -a $api_key
    echo "Pushing to Mailchimp using API key"
  else
    ./node_modules/.bin/md2mc -m $final_file -t template.mjml -o $folder_name
    echo "Generated HTML, Mailchimp push skipped."
  fi
else
  echo "HTML generation skipped."
fi

