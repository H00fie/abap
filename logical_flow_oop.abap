*---------------------------------------------------------------------------------------------------------------------------------
*PROGRAM FLOW CONTROL AND LOGICAL EXPRESSIONS
*---------------------------------------------------------------------------------------------------------------------------------

*IF----------------------------------------
DATA: item TYPE string.
item = 'mug'.

IF item = 'mug'.
  WRITE: 'I can make if statements.'.
ELSE.
  WRITE: 'I cannot.'.
ENDIF.
ULINE.



*Linking logical expressions together----------------------------------------
*There is the old way of writing logical operators:
*EQ - equals,
*NE - not equals,
*LT - less than,
*GT - greater than,
*LE - less or equal,
*GE - greater or equal.

*I am doing OOP for fun <3
CLASS dog DEFINITION.
  PUBLIC SECTION.

    CLASS-DATA: num_of_dogs TYPE i.
    CLASS-METHODS class_constructor. "A static constructor.

    METHODS constructor
      IMPORTING
         name            TYPE c
         age             TYPE i
         breed           TYPE c
         happiness_level TYPE i.

    METHODS: pet IMPORTING increment TYPE i EXPORTING result TYPE i,
             view_dog,
             show_the_dog_log,
             get_happiness_level            EXPORTING result TYPE i,
             get_name                       EXPORTING result TYPE c.

  PRIVATE SECTION.
    DATA: name(30)            TYPE c,
          age                 TYPE i,
          breed(30)           TYPE c,
          happiness_level     TYPE i.

    CLASS-DATA: dog_log TYPE i. "Used by my static constructor.
ENDCLASS.                    "dog DEFINITION
*----------------------------------------------------------------------*
*       CLASS dog IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS dog IMPLEMENTATION.
  METHOD class_constructor. "The calculations do not really make sense, I think. I declared dog_log in a private section. I would need to prepare a method to reach for it.
    IF dog_log NE 0.
      dog_log = dog_log + 1.
    ELSE.
      dog_log = 1.
    ENDIF.
    WRITE: / 'Class dog (a classy dog!) has been used!'.
    WRITE: / 'Current number of good bois is: ', dog_log.
  ENDMETHOD.                    "class_constructor

  METHOD constructor.
    me->name = name.
    me->age = age.
    me->breed = breed.
    me->happiness_level = happiness_level.
    num_of_dogs = num_of_dogs + 1.
  ENDMETHOD.                    "constructor

  METHOD pet.
    happiness_level = happiness_level + increment.
  ENDMETHOD.                    "pet

  METHOD view_dog.
    WRITE: 'Name: ', name.
    WRITE: 'Age: ', age.
    WRITE: 'Breed: ', breed.
    WRITE: 'Happiness level: ', happiness_level.
  ENDMETHOD.                    "view_dog

  METHOD show_the_dog_log.
    WRITE: dog_log.
  ENDMETHOD.                    "show_the_dog_log

  METHOD get_happiness_level.
    result = happiness_level.
  ENDMETHOD.                    "get_happiness_level

  METHOD get_name.
    result = name.
  ENDMETHOD.                    "get_name

ENDCLASS.                    "dog IMPLEMENTATION


START-OF-SELECTION. "Telling ABAP where I want to start the processing of my program.

  DATA: dog_bravo TYPE REF TO dog,
        dog_delta TYPE REF TO dog.

  CREATE OBJECT: dog_bravo "The consturctor requires parameters so I need to pass them here. Shocking, innit?!
    EXPORTING
      name            = 'Attalos'
      age             = 2
      breed           = 'Huskylamute'
      happiness_level = 10.
  CREATE OBJECT: dog_delta
    EXPORTING
      name            = 'Kasztanek'
      age             = 1
      breed           = 'Huskylamute'
      happiness_level = 10.

  CALL METHOD: dog_bravo->view_dog.
  ULINE.
  CALL METHOD: dog_delta->view_dog.
  ULINE.

  DATA: the_result TYPE i.

*Below means - on dog_bravo call a method 'pet', put into the method 'increment' which has the value of 4, and take out
*the 'result' (both 'increment' and 'result' are the innards of the 'pet' method and upon the extraction of the result
*assign it to 'the_result'.)
  CALL METHOD: dog_bravo->pet( EXPORTING increment = 4 IMPORTING result = the_result ).
  CALL METHOD: dog_bravo->view_dog.
  ULINE.
*Both good bois deserve petting.
  CALL METHOD: dog_delta->pet( EXPORTING increment = 4 IMPORTING result = the_result ).
  CALL METHOD: dog_delta->view_dog.
  ULINE.

*CALL METHOD dog_bravo->show_the_dog_log. <---- technically, it works, but seems pointless. I basically require a method called on an object here
  "because I declared 'dog_log' in private section. And it's always one anyway, I think, since it's
  "used by the static constructor, it only can be called upon the creation of the first object
  "and that value will just not increment... because the incrementation is defined within the class
  "constructor.

*To call a static attribute of 'num_of_dogs'.
  DATA: the_number_that_matters TYPE i.
  the_number_that_matters = dog=>num_of_dogs.
  WRITE: / 'There are currently ', the_number_that_matters, ' good bois around.'.

*And now about that linkage of logical expressions...
  DATA: new_result1 TYPE i.
  DATA: new_result2 TYPE i.
  CALL METHOD: dog_bravo->get_happiness_level( IMPORTING result = new_result1 ).
  CALL METHOD: dog_delta->get_happiness_level( IMPORTING result = new_result2 ).

  IF new_result1 EQ 14 AND new_result2 EQ 14.
    WRITE: / 'Both puppers are happy!'.
  ELSE.
    WRITE: / 'Fix that method, mate.'.
  ENDIF.
  ULINE.



*Nested IFs----------------------------------------
  DATA: name_keeper(30) TYPE c,
        name_holder(30) TYPE c.

  CALL METHOD: dog_bravo->get_name( IMPORTING result = name_keeper ).
  CALL METHOD: dog_delta->get_name( IMPORTING result = name_holder ).
  IF name_keeper EQ 'Attalos'.
    IF name_holder EQ 'Kasztanek'.
      WRITE: 'Pupperino victoria.'.
    ELSE.
      WRITE: 'Second condition failed.'.
    ENDIF.
  ELSE.
    WRITE: 'First condition failed.'.
  ENDIF.
  ULINE.



*Case statement----------------------------------------
*Kind of a Java's switch. They can be nested too.
  CASE name_holder.
    WHEN 'Attalos'.
      WRITE: / 'A little pup!'.
      CASE name_holder.               "A nested case.
        WHEN 'Kasztanek'.             "A nested case.
          WRITE: / 'A little pup 2!'. "A nested case.
        WHEN OTHERS.                  "A nested case.
          WRITE: 'Fix, lol!'.         "A nested case.
      ENDCASE.                        "A nested case.
    WHEN 'Kasztanek'.
      WRITE: 'A little doggy!'.*    WHEN OTHERS.
      WRITE: 'Fix that method so that it shows DOGS.'.
  ENDCASE.
  ULINE.
  
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------