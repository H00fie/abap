*---------------------------------------------------------------------------------------------------------------------------------
*DATE AND TIME FIELDS.
*---------------------------------------------------------------------------------------------------------------------------------
*Date and time fields are NOT defined as numeric data types, but character data types. They are characeter strings that can be used in calculations. It's possible
*thanks to automatic data types' conversions.

DATA: my_date  TYPE d.        "D is always 8 characters -> first four a year, next two a month and the last two a day. Much like sy-datum then. If I do not specify the value, defaults to 0 (00000000).
DATA: my_date2 LIKE sy-datum. "I can use LIKE if I already know a date data type and want to copy its structure.

*Time fields are 6 character long -> HHMMSS (default 000000).
DATA: my_time TYPE t.
DATA my_time2 LIKE sy-uzeit. "System time, like sy-datum being system date.

*Both my_date2 and my_time2 are all 0s, because the data types are LIKE them (structure-wise), they do not assume their values.
WRITE: / my_date.
ULINE.
WRITE: / my_date2.
ULINE.
WRITE: / my_time.
ULINE.
WRITE: / my_time2.
ULINE.

*Below will be displayed as '16.05.1989' because WRITE applies its own formatting which is associated with my user logon.
my_date = '19890516'.
WRITE: / my_date.
ULINE.



*CALCULATIONS WITH DATE FIELDS----------------------------------------
DATA: empl_sdate        TYPE d,
      todays_date       TYPE d,
      length_of_service TYPE i.

empl_sdate        = '20210607'.
todays_date       = sy-datum.
length_of_service = todays_date - empl_sdate. "On 23.10.2021 I worked for CEDC for 138 days!
WRITE: length_of_service.
ULINE.

**********************************

DATA: days_count  TYPE i,
      future_date TYPE d.

days_count  = 20.
future_date = todays_date + days_count. "The date is calculated correctly just by adding an integer (which here represents days) <3
WRITE: future_date.
ULINE.

**********************************

*Subfield ->I can change the date like that to, say, represent the 20th of the current month instead of an actual date.
todays_date = sy-datum.
todays_date+6(2) = '20'.
WRITE todays_date.
ULINE.

*Subtracking the value -> e.g. choosing the last day of the previous month.
todays_date = sy-datum.
todays_date+6(2) = '01'. "Set the current month's day to the first...
todays_date = todays_date - 1.
WRITE todays_date.
ULINE.



*CALCULATIONS WITH TIME FIELDS----------------------------------------
DATA: clock_in     TYPE t,
      clock_out    TYPE t,
      seconds_diff TYPE i,
      minutes_diff TYPE i,
      hours_diff   TYPE p DECIMALS 2.

clock_in  = '073000'. "This is 07:30:00 (HHMMSS).
clock_out = '160000'.

*SECONDS:
seconds_diff = clock_out - clock_in.
WRITE: 'Clock-in time is: ', clock_in, 'Clock-out time is: ', clock_out.
WRITE: / 'The time spent in seconds is: ', seconds_diff.

*MINUTES:
minutes_diff = seconds_diff / 60.
WRITE: / 'The time spent in minutes is: ', minutes_diff.

*HOURS:
hours_diff = minutes_diff / 60.
WRITE: / 'The time spent in hours is: ', hours_diff.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------