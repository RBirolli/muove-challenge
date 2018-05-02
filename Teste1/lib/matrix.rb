class Matrix

  def initialize(file_path)
    # Formatar o dicionario com os dados contidos no aquivo dict.txt,
    # gerando um array usando semente as palavras.
    @dict_array = File.read(file_path).lines.map { |l| l.split(/\s+/).first }
  end

  def new(grid_size)
    # Gerar uma matriz com N linhas e N colunas contendo uma letra em cada posição
    if grid_size > 0
      @grid_size = grid_size      # Dimensão da Matriz
      @chars_matrix = []          # Matriz gerada

      @grid_size.times do |line|
        @chars_matrix[line] = []
        @grid_size.times { |collumm| @chars_matrix[line] << [*'A'..'Z'][rand(26)] }
      end
    end
  end

  def show_matrix
    # Exibir a matriz formatada
    puts
    @grid_size.times { |line| puts ("#{@chars_matrix[line]}") }
  end

  def get_words_fom_lines(orientation)
    # Identificar todas as palavras contidas nas N linhas
    temp_array = []
    @grid_size.times do |line|
      # Processar as linhas invidualmente
      temp_array += process_line(@chars_matrix[line].join, orientation)
    end

    # Retornar a listra de palavras obtidas
    search_word_dictionary(remove_duplicate(temp_array))
  end

  def get_words_fom_collums(orientation)
    # Identificar todas as palavras contidas nas N colunas
    search_word_dictionary(remove_duplicate(process_diagonal(0, 1, 0, orientation)))
 end

  def get_words_from_diagonal(orientation)
    # Identificar todas as palavras contidas nas N colunas
    result_array = []
    result_array += process_diagonal(0, 1, 1, orientation)
    result_array += process_diagonal((@grid_size - 1), -1, -1, orientation)
    result_array += process_diagonal(0, 1, -1, orientation)
    result_array += process_diagonal((@grid_size - 1), -1, 1, orientation)

    # Retornar a lista de palavras obtidas
    search_word_dictionary(remove_duplicate(result_array))
  end

  private

  def process_diagonal(x, x_factor, y_factor, orientation)
    # Extrair todas as palavras das diagonais definidas por X, 
    # usando os fatores para percorrer as diagonais
    temp_array = []
    for i in (0..(@grid_size - 1))
      loop_x = x
      loop_y = i
      aux_line= ""
      begin
        # Extrair caracteres da diagonal de acordo com os fatores informados
        aux_line += (@chars_matrix[loop_x][loop_y]).to_s rescue break
        loop_x += x_factor
        loop_y += y_factor
      end while (loop_y < @grid_size) && (loop_y >= 0)

      # Processar todas as palavras encontradas
      (temp_array += process_line(aux_line, orientation)) if aux_line.length > 1
    end

    # Retornar o resultado obtido
    temp_array
  end

  def process_line(line_chars, orientation)
    # Extrair palavras da linha
    line_size = line_chars.length
    temp_array = []
    line_size.times do |collum|
      char_aux = line_chars[line_size - collum - 1]
      for i in (1...line_size)
        if orientation == 'L'
        # Montar palavras da esquerda para direita
          temp_array << line_chars[collum..(collum + i)] if (collum + i) < line_size
        else
        # Montar palavras da direita para a esquerda
           ((collum + i) < (line_size)) ? temp_array << (char_aux += line_chars[line_size - collum - i - 1]) : break
         end
      end
    end

    # Retorna lista de palavras encontradas
    temp_array
  end

  def remove_duplicate(search_array)
    # Remove palavras duplicadas do array
    temp_array = []
    search_array.each do |word|
      for i in (0..temp_array.size)
        break if word == temp_array[i]
      end

      # Salva no resultado se é uma palavra nova...
      temp_array << word.to_s if i ==  temp_array.size
    end

    # Retorna array processado
    temp_array
  end

  def search_word_dictionary(search_array)
    # Verificar se tem palavras na lista que constam no dicionario.
    words_array = ""
    search_array.each do |word|
      for i in (0..@dict_array.size)
        if word == @dict_array[i]
          words_array += (word + " ")
          break
        end
      end
    end

    # Retorna a lista de palavras encontradas...
#    words_array.join(", ")
    words_array
  end
end
