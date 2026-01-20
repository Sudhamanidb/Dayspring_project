📅 Day 7 – Ruby OOP (Inheritance & Method Overriding)

On Day 7, I learned the core Object-Oriented Programming concepts in Ruby, focusing on how classes interact using inheritance and how methods can be overridden.

Topics Covered
Classes & Objects

A class is a blueprint for creating objects.

An object is an instance of a class.

Methods define the behavior of an object.

Instance variables (@variable) store object-specific data.

Inheritance

Inheritance allows one class to reuse another class’s methods and variables.

Child classes inherit behavior from parent classes using <.

Helps reduce code duplication.

Parent instance variables are accessible in child classes.

Method Overriding

Child class can redefine a method from the parent class.

Ruby always calls the child method first if names match.

Overriding is used to change or extend existing behavior.

super Keyword

super calls the parent class method.

Can be used with or without arguments.

Helps extend parent functionality instead of replacing it.

Method Lookup

Ruby searches for methods in this order:

Current class

Parent class

Modules

Object

ancestors shows the method lookup chain.
