
"""This is a Python script that defines a function to query the Docker Hub API for the number of downloads of a specific Docker image. The function takes an optional parameter `image_name` which defaults to "kestra/kestra". It makes a GET request to the Docker Hub API, retrieves the JSON response, and extracts the 'pull_count' which represents the number of downloads. 
The result is printed and returned. 
The script also includes a section to set up outputs for Kestra and a main block to execute the function when the script is run directly.
"""
from kestra import Kestra
import requests

def get_docker_image_downloads(image_name: str = "kestra/kestra"):
          """Queries the Docker Hub API to get the number of downloads for a specific Docker image."""
          url = f"https://hub.docker.com/v2/repositories/{image_name}/"
          response = requests.get(url)
          data = response.json()
          print(data)
          downloads = data.get('pull_count', 'Not available')
          return downloads

downloads = get_docker_image_downloads()
outputs = {
          'downloads': downloads
      }
Kestra.outputs(outputs)

if __name__==  "__main__":
    get_docker_image_downloads()