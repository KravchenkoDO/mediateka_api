require 'rails_helper'

RSpec.describe Movie, :type => :model do

  describe 'validation tests' do

    let(:movie_with_title_nil) { described_class.new title: nil }
    let(:movie_with_empty_title) { described_class.new title: '' }
    let(:movie_with_more_then_max_size_title) { described_class.new title: 'The HEAD Method HEAD is almost identical to GET, but without the response body.In other words, if GET /users returns a list of users, then HEAD /users will make the same request but will not return the list of users.
HEAD requests are useful for checking what a GET request will return before actually making a GET request - like before downloading a large file or response body' }
    let(:movie_with_empty_age_limit) { described_class.new age_limit: '' }
    let(:movie_with_more_max_size_age_limit) { described_class.new age_limit: 'PG-16-16' }
    let(:movie_with_more_then_max_size_description) { described_class.new description: 'Official Ruby FAQ
If you wish to report errors or suggest improvements for this FAQ, please go to our GitHub repository and open an issue or pull request.

General questions
What is Ruby?
Ruby is a simple and powerful object-oriented programming language, created by Yukihiro Matsumoto (who goes by the handle “Matz” in this document and on the mailing lists).

Like Perl, Ruby is good at text processing. Like Smalltalk, everything in Ruby is an object, and Ruby has blocks, iterators, meta-classes and other good stuff.

You can use Ruby to write servers, experiment with prototypes, and for everyday programming tasks. As a fully-integrated object-oriented language, Ruby scales well.

Ruby features:

Simple syntax,
Basic OO features (classes, methods, objects, and so on),
Special OO features (mixins, singleton methods, renaming, and so on),
Operator overloading,
Exception handling,
Iterators and closures,
Garbage collection,
Dynamic loading (depending on the architecture),
High transportability (runs on various Unices, Windows, DOS, macOS, OS/2, Amiga, and so on).
Show me some Ruby code!
Let’s define a class called Person, with a name and an age. We’ll test our code by creating a few people and examining them.

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age  = age.to_i
  end

  def inspect
    "#{name} (#{age})"
  end
end

p1 = Person.new("Elmo", 4)
p2 = Person.new("Zoe", 7)

p1  # => Elmo (4)
p2  # => Zoe (7)
Now let’s populate an array of people by reading their names and ages from a file ages containing lines like:

Bert:    8
Cookie: 11
Elmo:    4
Ernie:   8
Zoe:     7
The code uses regular expressions to parse successive lines from the input file, creating a new Person object for each match and pushing it onto the end of the array people.

people = Array.new

File.foreach("ages") do |line|
  people << Person.new($1, $2) if line =~ /(.*):\s+(\d+)/
end

people  # => [Bert (8), Cookie (11), Elmo (4), Ernie (8), Zoe (7)]
Now, let’s sort the result based on the person’s age. There are many ways to do this. We can define a sort block, which tells Ruby how to do the comparison of two people:

sorted = people.sort {|a, b| a.age <=> b.age }
sorted  # => [Elmo (4), Zoe (7), Bert (8), Ernie (8), Cookie (11)]
Another way would be to change the comparison method for class Person:

class Person
  def <=>(other)
    age <=> other.age
  end
end
people.sort  # => [Elmo (4), Zoe (7), Bert (8), Ernie (8), Cookie (11)]
Why the name “Ruby”?' }

    it "is not valid without a title" do
      expect(movie_with_title_nil.valid?).to be_falsey
    end

    it "is not valid with empty title attribute" do
      expect(movie_with_empty_title.valid?).to be_falsey
    end

    it "is not valid with title attribute more then 255 chars" do
      expect(movie_with_more_then_max_size_title).to_not be_valid
    end

    it "is not valid with empty age_limit attribute" do
      expect(movie_with_empty_age_limit.valid?)
    end

    it "is not valid with age_limit attribute more then 6 chars" do
      expect(movie_with_more_max_size_age_limit).to_not be_valid
    end

    it "is not valid with description attribute more then 2000 chars" do
      expect(movie_with_more_then_max_size_description).to_not be_valid
    end
  end

  describe "columns" do
    it{is_expected.to have_db_column(:title).of_type(:string)}
    it{is_expected.to have_db_column(:description).of_type(:string)}
    it{is_expected.to have_db_column(:age_limit).of_type(:string)}
    it{is_expected.to have_db_column(:budget).of_type(:integer)}
    it{is_expected.to have_db_column(:box_office).of_type(:integer)}

  end
end
