# frozen_string_literal: true

RSpec.describe Jekyll::WebAwesome do
  it 'has a version number' do
    expect(Jekyll::WebAwesome::VERSION).not_to be nil
  end

  describe 'configuration' do
    it 'has default debug_mode set to false' do
      config = Jekyll::WebAwesome::Configuration.new
      expect(config.debug_mode).to be false
    end

    it 'allows setting debug_mode' do
      config = Jekyll::WebAwesome::Configuration.new
      config.debug_mode = true
      expect(config.debug_mode).to be true
    end
  end
end
