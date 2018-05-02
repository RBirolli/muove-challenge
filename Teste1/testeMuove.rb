require_relative 'lib/matrix'

# Carregar o dicionario em memoria
matrix = Matrix.new("../dict.txt")

begin
  # Obter o tamanho do grid e gerar a Matriz de Letras
  printf "\nInformar o tamanho do Grid: "
  matrix_size = gets.chomp.to_i

  if matrix_size > 0
    # Exibir a matriz formatada
    matrix.new(matrix_size)
    matrix.show_matrix

    # Obter as palavras contidas nas linhas
    puts "\nPalavras contidas nas linhas da esquerda para a direita: "
    result = matrix.get_words_fom_lines("L")
    puts "#{result}"

    # Obter as palavras contidas nas linhas
    puts "\nPalavras contidas nas linhas da direita para a esquerda: "
    result = matrix.get_words_fom_lines("R")
    puts "#{result}"

    # Obter as palavras contidas nas colunas
    puts "\nPalavras contidas nas colunas de cima para baixo: "
    result = matrix.get_words_fom_collums("L")
    puts "#{result}"

    # Obter as palavras contidas nas colunas
    puts "\nPalavras contidas nas colunas de baixo para cima: "
    result = matrix.get_words_fom_collums("R")
    puts "#{result}"

    # Obter as palavras contidas nas diagonais
    puts "\nPalavras contidas nas diagonais de cima para baixo: "
    result = matrix.get_words_from_diagonal("L")
    puts "#{result}"

    # Obter as palavras contidas nas diagonais
    puts "\nPalavras contidas nas diagonais de baixo para cima: "
    result = matrix.get_words_from_diagonal("R")
    puts "#{result}"
  end
end while matrix_size > 0

puts "\n*****  Fim do teste *****"


