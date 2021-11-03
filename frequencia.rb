class Palavra
    attr_accessor :palavra 
    attr_accessor :frequencia
  
    def initialize(palavra, frequencia)
      @palavra = palavra
      @frequencia = frequencia
    end
  end
  
  class AnalisadorLinha
      attr_accessor :numeroLinha, :textoLinha, :palavraFrequente
      def initialize (numeroLinha, textoLinha)
          @numeroLinha = numeroLinha
          @textoLinha = textoLinha
          @palavraFrequente=Array.new{}
      end
      
      def contador()
          palavrasHash = Hash.new {0}
          @textoLinha.each { |palavra|
            if palavrasHash.has_key? palavra
              palavrasHash[palavra] += 1
            else
              palavrasHash[palavra] = 1
            end
          }
        
          return palavrasHash
      end
      
      def addFrequente(hash)
          flg = 0
          hash.each { |key, value|
            if value >= flg
              palavra = Palavra.new(key, value)
              @palavraFrequente.push(palavra)
              flg = value
            else
              break
            end
          }
      end
  
      def ordenarHash(hash)
          return Hash[hash.sort_by {|k, v| -v}]
      end
  
      def contar()
          hash = contador()
          ordenado = ordenarHash(hash)
          addFrequente(ordenado)
      end
  
      def to_str
          return "Mais frequentes: #{@palavraFrequente} na linha #{@numeroLinha}"
      end
  end
  
  file = File.read("arquivo.txt")
  analisador_arr = Array.new{0}
  linhas = file.split("\n")
  linhas.each_with_index {|linha, index|
      palavras = linha.split(" ")
      ob = AnalisadorLinha.new(index+1,palavras)
      ob.contar()
      analisador_arr.push(ob)
  }
  
  analisador_arr.each { |item|
    item.palavraFrequente.each { |palavra|
      puts "Palavra: #{palavra.palavra}\nFrequencia: #{palavra.frequencia}\nLinha: #{item.numeroLinha}"
      puts "#############################"
    }
  }
  