# Code Book

The tidy data set in this project was derived from the raw data set that comes from the accelerometer and gyroscope 3-axial raw signals.

## Data

The tidy data set contains the following columns:
1. Subject - numbers 1-30.
2. Activity - represented by six labels: WALKING
, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS
, SITTING
, STANDING
, LAYING

3. Measurement - Several mean and standard deviation measurements from the raw data.
4. Mean - mean of the measurement for each activity performed by the subject.

## Transformations

The tidy data set was derived from the raw data set after the following transformations were performed on the raw data:
1. Subject - no transformations. It contains the same identifies used in the raw data.
2. Activity - the activity numeric identifiers in the raw data are replaced by the actual text labels.
3. Measurement - only the columns containing mean and standard deviation measurements were extracted from the raw data. 

## Clean up

The raw data contained hundreds of columns for each measurement. The tidy set, instead, contains a single column "Measurement" with the name of the measurement.
