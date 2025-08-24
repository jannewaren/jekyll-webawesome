# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Jekyll::WebAwesome::CodeBlockTransformer do
  describe 'transform configuration' do
    let(:site) { double('site', config: site_config) }

    describe '.transform_pages_enabled?' do
      context 'when no configuration is set' do
        let(:site_config) { {} }

        it 'returns true by default' do
          expect(described_class.transform_pages_enabled?(site)).to be true
        end
      end

      context 'when site config has transform_pages set to false' do
        let(:site_config) { { 'webawesome' => { 'transform_pages' => false } } }

        it 'returns false' do
          expect(described_class.transform_pages_enabled?(site)).to be false
        end
      end

      context 'when WebAwesome module configuration has transform_pages disabled' do
        let(:site_config) { {} }

        before do
          Jekyll::WebAwesome.configure do |config|
            config.transform_pages = false
          end
        end

        after do
          Jekyll::WebAwesome.configuration = nil
        end

        it 'returns false' do
          expect(described_class.transform_pages_enabled?(site)).to be false
        end
      end
    end

    describe '.transform_documents_enabled?' do
      context 'when no configuration is set' do
        let(:site_config) { {} }

        it 'returns true by default' do
          expect(described_class.transform_documents_enabled?(site)).to be true
        end
      end

      context 'when site config has transform_documents set to false' do
        let(:site_config) { { 'webawesome' => { 'transform_documents' => false } } }

        it 'returns false' do
          expect(described_class.transform_documents_enabled?(site)).to be false
        end
      end

      context 'when WebAwesome module configuration has transform_documents disabled' do
        let(:site_config) { {} }

        before do
          Jekyll::WebAwesome.configure do |config|
            config.transform_documents = false
          end
        end

        after do
          Jekyll::WebAwesome.configuration = nil
        end

        it 'returns false' do
          expect(described_class.transform_documents_enabled?(site)).to be false
        end
      end
    end
  end
end
