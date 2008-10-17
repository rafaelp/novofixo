require 'open-uri'

module Captchator

  private

  def captcha_pass?(session, answer)
    session = session.to_i
    answer  = answer.gsub(/\W/, '')
    open("http://captchator.com/captcha/check_answer/#{session}/#{answer}").read.to_i.nonzero? rescue false
  end
end
