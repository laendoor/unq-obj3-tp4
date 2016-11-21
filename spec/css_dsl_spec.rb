require 'spec_helper'

describe CssDSL do

  describe 'Parte 1: clases, IDs y propiedades básicas de CSS' do
    it 'compila selectores' do
      css = CssDSL.new.stylesheet do
        body
        _class {}
        __id
        div_class
        h1__id {}
      end

      css_expected = 'body {} .class {} #id {} div.class {} h1#id {}'

      expect(css.compile.minify).to eq css_expected
    end

    it 'compila .claseSuelta con propiedad fontSize' do
      css = CssDSL.new.stylesheet do
        _claseSuelta {
          fontSize 16.px
        }
      end

      css_expected = '.claseSuelta { font-size: 16px; }'

      expect(css.compile.minify).to eq css_expected
    end

    it 'compila body con propiedades background' do
      css = CssDSL.new.stylesheet do
        body {
          background {
            color rgb(255,0,255)
            width 80.px
            height 80.px
          }
        }
      end

      css_expected = 'body { background-color: #FF00FF; background-size: 80px 80px; }'

      expect(css.compile.minify).to eq css_expected
    end
  end

end
