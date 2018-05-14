# require 'spec_helper'
# require 'credit_card_classifier'
#
# describe CreditCardClassifier do
#   describe '#classify' do
#     let(:visa_cards) do
#       [
#         4_242_424_242_424,
#         4_242_424_242_424_242,
#         4_242_424_242_424_242_424
#       ]
#     end
#     let(:amex_cards) do
#       [
#         344_242_424_242_424,
#         374_242_424_242_424
#       ]
#     end
#     let(:unknown_cards) do
#       [
#         974_242_424_242_424
#       ]
#     end
#
#     let(:discover_cards) do
#       [
#         6_229_254_242_424_242,
#         6_221_264_242_424_242,
#         6_222_264_242_424_242,
#         6_522_264_242_424_242
#       ]
#     end
#     let(:electron_cards) do
#       [
#         4_175_004_242_424_242,
#         4_508_424_242_424_242,
#         4_917_424_242_424_242
#       ]
#     end
#     let(:jcb_cards) do
#       [
#         358_942_424_242_424_242,
#         356_042_424_242_424_242
#       ]
#     end
#     it 'is visa for Visa cards' do
#       visa_cards.each do |cc|
#         expect(subject.classify(cc.to_s)).to eq 'visa'
#       end
#     end
#     it 'is amex for Amex cards' do
#       amex_cards.each do |cc|
#         expect(subject.classify(cc.to_s)).to eq 'amex'
#       end
#     end
#     it 'is discover for Discover cards' do
#       discover_cards.each do |cc|
#         expect(subject.classify(cc.to_s)).to eq 'discover'
#       end
#     end
#     it 'is electron for Electron cards' do
#       electron_cards.each do |cc|
#         expect(subject.classify(cc.to_s)).to eq 'electron'
#       end
#     end
#     it 'is jcb for JCB cards' do
#       jcb_cards.each do |cc|
#         expect(subject.classify(cc.to_s)).to eq 'jcb'
#       end
#     end
#     it 'is unknown for unknown card types' do
#       unknown_cards.each do |cc|
#         expect(subject.classify(cc.to_s)).to eq 'unknown'
#       end
#     end
#   end
#
#   describe '#visa?' do
#     it 'is true when the card number is 13, 16, or 19 characters and begins with 4' do
#       expect(subject.visa?('4242424242424')).to be true
#       expect(subject.visa?('4242424242424242')).to be true
#       expect(subject.visa?('4242424242424242424')).to be true
#     end
#     it 'is false when the card does not begin with 4' do
#       expect(subject.visa?('3242424242424')).to be false
#       expect(subject.visa?('3242424242424242')).to be false
#       expect(subject.visa?('3242424242424242424')).to be false
#     end
#     it 'is false when the card is not 13, 16, or 19 characters' do
#       expect(subject.visa?('42424242424244')).to be false
#       expect(subject.visa?('42424242424242424')).to be false
#       expect(subject.visa?('42424242424242424244')).to be false
#     end
#   end
#
#   describe '#amex?' do
#     it 'is true when the card number is 15 characters long and begins with 34' do
#       expect(subject.amex?('344242424242424')).to be true
#     end
#     it 'is true when the card number is 15 chars long and begins with 37' do
#       expect(subject.amex?('374242424242424')).to be true
#     end
#     it 'is false when the card number is not 15 characters long' do
#       expect(subject.amex?('3742424242424244')).to be false
#     end
#     it 'is false when the card does not begin with 34 or 37' do
#       expect(subject.amex?('384242424242424')).to be false
#     end
#   end
#
#   describe '#discover?' do
#     it 'is true when the number is 16 characters long and starts with six numbers inclusively between 622126 and 622925' do
#       expect(subject.discover?('6229254242424242')).to be true
#       expect(subject.discover?('6221264242424242')).to be true
#       expect(subject.discover?('6222264242424242')).to be true
#     end
#
#     it 'is true when the number is 17 characters and starts with 65' do
#       expect(subject.discover?('6522264242424242')).to be true
#     end
#
#     it 'is false for numbers less than 16 characters' do
#       expect(subject.discover?('652226424242424')).to be false
#     end
#   end
#
#   describe '#electron?' do
#     it 'is true when the card is a Visa with 16 characters and begins with 417500, 4026, 4508, 4844, 4913, or 4917' do
#       expect(subject.electron?('4175004242424242')).to be true
#       expect(subject.electron?('4026424242424242')).to be true
#       expect(subject.electron?('4508424242424242')).to be true
#       expect(subject.electron?('4844424242424242')).to be true
#       expect(subject.electron?('4913424242424242')).to be true
#       expect(subject.electron?('4917424242424242')).to be true
#     end
#     it 'is false when the card begins with any other sequence' do
#       expect(subject.electron?('4242424242424242')).to be false
#     end
#   end
#
#   describe '#jcb?' do
#     it 'is true when the card is 18 characters and begins with values between 3528 and 3589' do
#       expect(subject.jcb?('352842424242424242')).to be true
#       expect(subject.jcb?('358942424242424242')).to be true
#       expect(subject.jcb?('356042424242424242')).to be true
#     end
#     it 'is false when the card begins with any other sequence' do
#       expect(subject.jcb?('359142424242424242')).to be false
#     end
#   end
# end
