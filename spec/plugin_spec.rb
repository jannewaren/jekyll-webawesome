# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Jekyll::WebAwesome::Plugin do
  describe '.debug_enabled?' do
    let(:site_config) { {} }
    let(:site) { double('site', config: site_config) }

    context 'when no debug configuration is set' do
      it 'returns false' do
        expect(Jekyll::WebAwesome::Plugin.debug_enabled?(site)).to be false
      end
    end

    context 'when webawesome.debug is true in site config' do
      let(:site_config) { { 'webawesome' => { 'debug' => true } } }

      it 'returns true' do
        expect(Jekyll::WebAwesome::Plugin.debug_enabled?(site)).to be true
      end
    end

    context 'when webawesome_debug is true in site config' do
      let(:site_config) { { 'webawesome_debug' => true } }

      it 'returns true' do
        expect(Jekyll::WebAwesome::Plugin.debug_enabled?(site)).to be true
      end
    end

    context 'when WebAwesome module configuration has debug_mode enabled' do
      before do
        Jekyll::WebAwesome.configure do |config|
          config.debug_mode = true
        end
      end

      after do
        Jekyll::WebAwesome.configure do |config|
          config.debug_mode = false
        end
      end

      it 'returns true' do
        expect(Jekyll::WebAwesome::Plugin.debug_enabled?(site)).to be true
      end
    end
  end

  describe '.markdown_file?' do
    it 'returns true for .md files' do
      expect(Jekyll::WebAwesome::Plugin.markdown_file?('test.md')).to be true
    end

    it 'returns true for .MD files' do
      expect(Jekyll::WebAwesome::Plugin.markdown_file?('test.MD')).to be true
    end

    it 'returns false for non-markdown files' do
      expect(Jekyll::WebAwesome::Plugin.markdown_file?('test.html')).to be false
    end
  end
end
