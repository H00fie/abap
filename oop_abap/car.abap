*---------------------------------------------------------------------------------------------------------------------------------
*CAR. A CLASS CREATING EXERCISE
*---------------------------------------------------------------------------------------------------------------------------------

CLASS car DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA: numofcars TYPE i. "This is a static attribute! It is... static. Class-wide, amirite? Because calling methods on objects is so last season, kek.

*Constructors can also be static.
*-they always need to be in a PUBLIC SECTION,
*-there never is an interface -> I don't use any parameters at all,
*-it can only access static attributes of its class (because if I haven't instantiated an object, there's no data assigned to fields while static attributes are already there).
*Static constructors are executed the first time either an object of a class is created, either a static attribute of a class is used or a static method of a class is used.

    CLASS-METHODS class_constructor.

    METHODS constructor "Constructor is above other methods for visibility, whatever, it's not necessary.
      IMPORTING         "IMPORTING is the only thing a constructor can do. Soooo... like a Java constructor. It's all coming together.
        make     TYPE c "Initializing fields. Speed is not initialized, because I have other methods to decide the speed. Basically, there is no default speed.
        model    TYPE c
        seat_num TYPE i
        max_spd  TYPE i.

    METHODS: setnumseats IMPORTING newseatnum TYPE i, "The method sets the number of seats. So I am passing said new number of seats the method should set.
             gofaster    IMPORTING increment  TYPE i EXPORTING result TYPE i,
             goslower    IMPORTING decrement  TYPE i RETURNING value(result) TYPE i,
             viewcar.
*The difference between EXPORTING and RETURNING VALUE seems... non-existent. Just two different ways of doing it.

*Attributes are here so that only the methods of the class can update them. If a calling program wants to access them, it will need to do it by calling the
*methods of this class. So basically simple and obvious encapsulation. It's the same as in Java.
  PRIVATE SECTION.
    DATA: make     TYPE c LENGTH 20, "The lengths are whatever, really.
          model    TYPE c LENGTH 20,
          seat_num TYPE i,
          speed    TYPE i,
          max_spd  TYPE i.

    CLASS-DATA carlog TYPE c LENGTH 40. "My class_constructor uses it!


*    METHODS: setnumseats, gofaster, goslower.
ENDCLASS.                    "car DEFINITION

*----------------------------------------------------------------------*
*       CLASS car IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS car IMPLEMENTATION.

  METHOD class_constructor.
    carlog = 'Car class has been used'.
    WRITE: / carlog.
  ENDMETHOD.                    "class_constructor

*This is just a simple Java-like constructor, it's just shared between DEFINITION and IMPLEMENTATION. In the definition I pass the parameters and here I assign them to 'this' fields.
*If a parameter is called, e.g. make, I'd need to make the assigning look like: make = make. This causes ambiguity. There is an option to just not name parameters I am passing into
*the method the same as the arguments of my class... BUT I still can do things like in Java and I think it's the default solution for ABAP.
*There is a mechanism called SELF REFERENCE.
  METHOD constructor.
    me->make = make.
    me->model = model.
    me->seat_num = seat_num.
    me->max_spd = max_spd.     "I think that all these 'me->s' are an equivalent to Java's 'this'.
    numofcars = numofcars + 1. "This is a static field, so each time a new car is created, the overall number of them is incremented.
  ENDMETHOD.                    "constructor

  METHOD setnumseats.
    seat_num = newseatnum.
  ENDMETHOD.                    "setnumseats

  METHOD gofaster.                  "I am going to declare a local variable to help my calculations. I think it's 'theresult'
    IF speed + increment > max_spd. "added to store the value of 'result'! Its structure is a new concept for me - it's 'result = theresult'
      speed = max_spd.              "which applies the value of 'result' to the 'theresult', not the other way around.
    ELSE.
      speed = speed + increment.
    ENDIF.
    result = speed.
  ENDMETHOD.                    "gofaster

  METHOD goslower.
    IF speed - decrement <= 0.
      speed = 0.
    ELSE.
      speed = speed - decrement.
    ENDIF.
    result = speed.
  ENDMETHOD.                    "goslower

  METHOD viewcar. "Both the numeric values down there and the LEFT JUSTIFIED are just for placement of the data being written as the output.
    WRITE: / 'Make = '           , 19 make.
    WRITE: / 'Model = '          , 19 model.
    WRITE: / 'Number of seats = ', 19 seat_num LEFT-JUSTIFIED.
    WRITE: / 'Max speed = '      , 19 max_spd  LEFT-JUSTIFIED.
    WRITE: / 'Speed = '          , 19 speed    LEFT-JUSTIFIED.
  ENDMETHOD.                    "viewcar

ENDCLASS.                    "car IMPLEMENTATION

START-OF-SELECTION. "That's how I tell the system where I want it to start processing my code.

  DATA: theresult TYPE i.

  DATA: car_one TYPE REF TO car,
        car_two TYPE REF TO car.
  CREATE OBJECT: car_one "If there's no more code than this, I will get an error... because I made a constructor and it requires me to pass in parameters.
    EXPORTING            "This is how I pass in the parameters that constructor requires me to upon the creation of an object -> EXPORTING -> field -> gib valius.
      make = 'AUDI'
      model = 'A4'
      seat_num = 5
      max_spd = 120.

  CALL METHOD: car_one->viewcar.
  ULINE.

  CREATE OBJECT: car_two
    EXPORTING
      make = 'BMW'
      model = '320'
      seat_num = 5
      max_spd = 130.

  CALL METHOD: car_two->viewcar.
  ULINE.

*To see if the number of seats change.
  CALL METHOD: car_one->setnumseats( 8 ).
  CALL METHOD: car_one->viewcar.

*Another way of using the same method.
  CALL METHOD: car_one->setnumseats( newseatnum = 12 ).
  CALL METHOD: car_one->viewcar.
  ULINE.

*Playing around with gofaster method.
  CALL METHOD: car_one->gofaster( EXPORTING increment = 30 IMPORTING result = theresult ). "In here, somehow, 'result = theresult' means that the value of 'result' is stored in 'theresult', not the other way around.
  CALL METHOD: car_one->viewcar.
  WRITE: / 'The result of gofaster is:', theresult LEFT-JUSTIFIED.
  ULINE.

*Playing around with the goslower method.
  CALL METHOD: car_one->goslower( EXPORTING decrement = 10 RECEIVING result = theresult ). "goslower method has RETURNING instead of EXPORTING so it's RECEIVING, not IMPORTING).
  CALL METHOD: car_one->viewcar.
  WRITE: / 'The result of goslower is:', theresult LEFT-JUSTIFIED.
  ULINE.

  WRITE: / 'The number of cars created is:', car=>numofcars.
  ULINE.

*Supposedely the 'Old Way' of calling methods is: CALL METHOD classname=>methodname. and the 'New Way' is: classname=>methodname(). but I do not understand it.
*Methods are called upon objects of classes, not classes and it cannot be applied, to say, constructors (regular or static), because they are... constructors.
*Perhaps it applies only to static methods.
*INSTANCE METHODS USES '->' INSTEAD OF '=>' USED BY STATIC ONES.

*If I want to access a static attribute, I do it like that:
*  DATA some_var TYPE i.
*  some_var = car=>numofcars.
*  WRITE: / some_var.

*FUNCTIONAL METHOD------------------------------------------------------------------------------
*Basically this:
*CALL METHOD: car_one->goslower( EXPORTING decrement = 10 RECEIVING result = theresult ).
*Is equal to this:
*theresult = car_one->goslower( 10 ).
*The RECEIVING part is traded for assigning the method directly to the predefined variable and that leaves me with a single parameter... so the word EXPORTING can be omitted.

  theresult = car_one->goslower( 3 ).
  car_one->viewcar( ).
  WRITE: / 'The result of goslower (functional method) is:', theresult LEFT-JUSTIFIED.
  ULINE.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------