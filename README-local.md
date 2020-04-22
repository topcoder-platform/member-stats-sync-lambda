1.  Run `docker-compose up`

    ![A screenshot of a computer](./docs/media/image1.jpg)

2.  Run `npm run serverless:offline`

	![A screenshot of a computer screen](./docs/media/image2.jpg)

3.  Go to [http://localhost:8001](http://localhost:8001), and click on the `MemberStats` table.

    ![A screenshot of a computer](./docs/media/image3.jpg)

4.  Click on the `Create Item` button.

    ![A screenshot of a computer screen](./docs/media/image4.jpg)

5.  Enter the following sample data into the content editor, and click on the `Save` button.

    ![A screenshot of a computer screen](./docs/media/image5.jpg)

6.  Go to [http://localhost:9200/memberstats/_search?pretty](http://localhost:9200/memberstats/_search?pretty) to ensure that
    the data has been saved.

    ![A screenshot of a computer screen](.//docs/media/image6.jpg)