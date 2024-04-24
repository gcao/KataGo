#!/usr/bin/env ruby

pairs = %w[
  daoqi-s829795584-d13141612:daoqi-s961833984-d8749405
  daoqi-s829795584-d13141612:daoqi-s980315264-d10940344
  daoqi-s829795584-d13141612:daoqi-s991770368-d11953668
  daoqi-s961833984-d8749405:daoqi-s980315264-d10940344
  daoqi-s961833984-d8749405:daoqi-s991770368-d11953668
  daoqi-s980315264-d10940344:daoqi-s991770368-d11953668
]

pairs.each do |pair|
  model0, model1 = pair.split ":"
  f = File.open("/home/gcao/KataGo/cpp/configs/match_example2.cfg", "w")
  File.foreach("/home/gcao/KataGo/cpp/configs/match_example2.cfg.bak") do |line|
    if line =~ /^botName0 =/
      f.puts "botName0 = #{model0}"
    elsif line =~ /^botName1 =/
      f.puts "botName1 = #{model1}"
    elsif line =~ /^nnModelFile0 =/
      f.puts "nnModelFile0 = /home/gcao/daoqi-opencl-new/models/#{model0}/model.bin.gz"
    elsif line =~ /^nnModelFile1 =/
      f.puts "nnModelFile1 = /home/gcao/daoqi-opencl-new/models/#{model1}/model.bin.gz"
    else
      f.puts line
    end
  end
  f.close

  system "cpp/katago match -config cpp/configs/match_example2.cfg -sgf-output-dir /tmp/games"
  s = `cat /tmp/games/* |cut -b -160 |grep -e "PB\\[#{model1}.*\\[B\\+" -e "PW\\[#{model1}.*\\[W\\+" |wc |awk '{print $1}'`
  puts "#{model1} #{s.strip} : #{50 - s.strip.to_i} #{model0}"
  puts `cat /tmp/games/* |cut -b -160 |grep -e "PB\\[#{model1}.*\\[B\\+" -e "PW\\[#{model1}.*\\[W\\+"`
  `rm /tmp/games/*`
end
