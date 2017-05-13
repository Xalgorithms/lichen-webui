module Randomness
  @inst = Class.new { include Randomness }.new

  def self.invoke(meth, *args)
    @inst.send(meth, *args)
  end

  def rand_one(a)
    a.sample
  end

  def rand_some(a, n = nil)
    n ||= rand(a.length)
    a.sample(1 + n)
  end

  def maybe_call(prob=0.5, &bl)
    bl.call if Faker::Boolean.boolean(prob)
  end

  def rand_one_or_nil(a)
    rand(1) > 0 ? rand_one(a) : nil
  end

  def rand_times(i = 10)
    (1 + rand(i)).times
  end

  def rand_partition(a, n)
    i = rand(a.length / 3) + 1
    n == 1 ? [a] : [a.take(i).map(&:dup)] + rand_partition(a.drop(i), n - 1)
  end

  def rand_array(n = 10)
    rand_times(n).map { yield }
  end

  def rand_array_of_numbers(n = 10)
    rand_array(n) { Faker::Number.between(1, 1000).to_i }
  end

  def rand_array_of_words(n = 10)
    rand_array(n) { Faker::Hipster.word }
  end

  def rand_array_of_uuids(n = 10)
    rand_array(n) { UUID.generate }
  end

  def rand_array_of_hexes(n = 10)
    rand_array(n) { Faker::Number.hexadecimal(6) }
  end

  def rand_array_of_urls(n = 10)
    rand_array(n) { Faker::Internet.url }
  end

  def rand_array_of_file_names(n = 10)
    rand_array(n) { Faker::File.file_name }
  end

  def rand_array_of_models(name, args = {}, n = 10)
    rand_array(n) { create(name, args) }
  end

  def rand_document
    rand_array_of_hexes.inject({}) { |o, k| o.merge(k => Faker::Number.hexadecimal(10)) }
  end

  def unique_word
    "#{Faker::Lorem.word}-#{Faker::Number.number(3)}"
  end
end

RSpec.configure do |config|
  config.include(Randomness)
end
