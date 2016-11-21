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

    it 'compila someClass con argumento :hover' do
      css = CssDSL.new.stylesheet do
        a_someClass(:hover) {
          color :blue
        }
      end

      css_expected = 'a.someClass :hover { color: blue; }'

      expect(css.compile.minify).to eq css_expected
    end
  end

  describe 'Parte 2: Variables' do
    it 'compila utilizando variables' do
      css = CssDSL.new.stylesheet do
        let fondo = rgb(255, 0, 255)

        div_someDivClass {
          background {
            color fondo
          }
        }

        footer {
          background {
            color fondo
          }
        }
      end

      css_expected = 'div.someDivClass { background-color: #FF00FF; } footer { background-color: #FF00FF; }'

      expect(css.compile.minify).to eq css_expected
    end
  end

end
