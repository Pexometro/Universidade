class Grafo:
    def __init__(self, grafo):
        self.n = grafo

    def procura_DFS(self, start, end, path=[], visited=set()):
        path.append(start)
        visited.add(start)

        if start == end:
            custoT = self.calcula_custo(path)
            return (path, custoT)

        for (adjacente, peso) in self.n[start]:
            if adjacente not in visited:
                resultado = self.procura_DFS(adjacente, end, path, visited)
                if resultado is not None:
                    return resultado

        path.pop()
        return None

    def calcula_custo(self, path):
        # Função para calcular o custo total do caminho, você pode implementá-la de acordo com suas necessidades.
        # Vou assumir que o custo é a soma dos pesos das arestas.
        custo = 0
        for i in range(len(path) - 1):
            node1, node2 = path[i], path[i + 1]
            for (neighbor, peso) in self.n[node1]:
                if neighbor == node2:
                    custo += peso
        return custo

# Exemplo de usoclass Grafo:
    def __init__(self, grafo):
        self.n = grafo

    def procura_DFS(self, start, end, path=[], visited=set()):
        path.append(start)
        visited.add(start)

        if start == end:
            custoT = self.calcula_custo(path)
            return (path, custoT)

        for (adjacente, peso) in self.n[start]:
            if adjacente not in visited:
                resultado = self.procura_DFS(adjacente, end, path, visited)
                if resultado is not None:
                    return resultado

        path.pop()
        return None

    def calcula_custo(self, path):
        # Função para calcular o custo total do caminho, você pode implementá-la de acordo com suas necessidades.
        # Vou assumir que o custo é a soma dos pesos das arestas.
        custo = 0
        for i in range(len(path) - 1):
            node1, node2 = path[i], path[i + 1]
            for (neighbor, peso) in self.n[node1]:
                if neighbor == node2:
                    custo += peso
        return custo
'''
# Exemplo de uso
grafo = {
    's': [('a', 2), ('e', 2)],
    'a': [('b', 2)], 
    'b': [('c', 2)],
    'c': [('d', 3)],
    'd': [('t', 3)],
    'e': [('f', 5)],
    'f': [('g', 2)],
    'g': [('t', 2)],
    't': []
}
'''
grafo = {
    'Elvas': {'Alandroal': 40, 'Arrailos': 50, 'Borba': 15},
    'Alendroal': {'Redondo': 25},
    'Redondo': {'Monsaraz': 30},
    'Barreiro': {'Baixa Banheira': 5, 'Palmela': 25},
    'Palmela': {'Álcacer': 35, 'Almada': 25},
    'Baixa Banheira': {'Moita': 7},
    'Moita': {'Alcochete': 20},
    'Arrailos': {'Alcácer': 90},
    'Borba': {'Estremoz': 15},
    'Estremoz': {'Evora': 40},
    'Evora': {'Montemor': 20},
    'Montemor': {'Vendas Novas': 15},
    'Alcochete': {'Lisboa': 20},
    'Almada': {'Lisboa': 20},
    'Vendas Novas': {'Lisboa': 20},
    'Lisboa': {}
}

grafo_obj = Grafo(grafo)
start_node = 's'
end_node = 't'

resultado = grafo_obj.procura_DFS(start_node, end_node)
if resultado:
    caminho, custo_total = resultado
    print(f'Caminho de {start_node} para {end_node}: {caminho}')
    print(f'Custo total do caminho: {custo_total}')
else:
    print(f'Não foi encontrado um caminho de {start_node} para {end_node}.')
