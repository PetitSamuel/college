# ReviewApp
A team programming project done in 1st Year at TCD. A reviews app (such as yelp) done in processing.

This application can be ran using processing:
```
https://processing.org/download/
```

This project uses a MySql database hosted on AWS which I was personally in charge of setting up. I also was in charge of transitioning our application from using a small data set in CSV format to using a MySQL databse which enabled us to use a much larger data set of about 7GB worth of reviews, users and businesses data. This dataset can be found on yelps website.
```
https://www.yelp.com/dataset
```

On top of this I also was in charge of creating systems to transform the data into a displayable format, this included querying the database to get information about a review and using multiple methods to display everything nicely:
- displaying the stars and emojis given to a review
- displaying the text of the review and making sure that it fits the review box
- displaying the name of the user and the business being reviewed
- making a system which gets the height each review needs in order to display them consistantly with the same margin and not having them conflict
- displaying the appropriate reviews based on the scroll down menu that I also was in charge of

I also made sure that everything the team produced worked together amongst other smaller tasks.

We also included individual pages for users and businesses which included multiple graphs and locations (uses unfolding to generate the map).
