require File.expand_path('../spec_helper', __FILE__)

describe Pru do

  it 'has a VERSION' do
    Pru::VERSION.should =~ /\A\d+\.\d+\.\d+\z/
  end

  describe 'map' do

    it 'selects' do
      %x{ls -l | ./bin/pru 'include?("G")'}.split($/).size.should == 2
    end

    it 'selects via regex' do
      %x{ls -l | ./bin/pru /G/}.split($/).size.should == 2
    end

    it 'selects via i' do
      %x{cat spec/test.txt | ./bin/pru 'i'}.split($/)[0...3].should == %w[1 2 3]
    end

    it 'maps' do
      %x{echo abc | ./bin/pru 'gsub(/a/, "b")'}.should == "bbc\n"
    end

    it 'selects and reduces' do
      %x{cat spec/test.txt | ./bin/pru 'include?("abc")' 'size'}.should == "3\n"
    end

    it 'opens files' do
      %x{echo spec/test.txt | ./bin/pru 'File.read(self)'}.should == File.read('spec/test.txt')
    end

    it 'open preserves whitespaces' do
      %x{echo ' ab\tcd ' | ./bin/pru 'self'}.should == " ab\tcd \n"
    end

    it 'works with continuous input' do
      results = %x{ruby -e 'STDOUT.sync = true; puts 1; sleep 2; puts 1' | ./bin/pru 'Time.now.to_i'}.split($/)
      results.size.should == 2
      results.uniq.size.should == 2 # called at a different time -> parses as you go
    end

  end

  describe 'reduce' do

    it 'reduces' do
      %x{cat spec/test.txt | ./bin/pru -r 'size'}.should == "5\n"
    end

    it 'prints arrays as newlines' do
      %x{cat spec/test.txt | ./bin/pru -r 'self'}.should == File.read('spec/test.txt')
    end

    it 'can sum' do
      %x{cat spec/test.txt | ./bin/pru -r 'sum(&:to_i)'}.should == "1212\n"
    end

    it 'can mean' do
      %x{cat spec/test.txt | ./bin/pru -r 'mean(&:to_i)'}.should == "242.4\n"
    end

    it 'can grouped' do
      %x{cat spec/test.txt | ./bin/pru -r 'grouped.map { |a, b| b.size }'}.should include("2\n")
    end

  end

  describe 'map and reduce' do

    it 'selects with empty string and reduces' do
      %x{cat spec/test.txt | ./bin/pru '' 'size'}.should == "5\n"
    end

  end

end
