#     ESCUELA SUPERIOR DE COMPUTO 
#     PROCESAMEINTO DIGITAL DE IMAGENES
#     COMPRESION DE UNA IMAGEN
#     PRACTICA 7

using TestImages, ImageView, Images


function predictor(A) #Every 3x3 matrix will make the predictor process
    #Create matrix 
    out = zeros(size(A))
    # Get indices in vector form (1,1),(2,1),...,(f,c)
    coordinates = CartesianIndices(A)
    firstCoordinate, lastCoordinate = first(coordinates), last(coordinates)

    # Get positions of high frecuencies  (1,a) or (b,1)
    HighFre = [x for x in coordinates if x[1]==1 || x[2]==1]

    #range posible coordinates in the matrix
    for I in coordinates
        n = 0 #Number of neighbor pixels
        s = 0 #summatory of neighbor pixels
        # Get 3X3 submatrix 
        for J in max(firstCoordinate, I-firstCoordinate):min(lastCoordinate, I+firstCoordinate)
            #Add neighbor pixels
            s += A[J] 
            for x in A[J] 
                if x != 0
                    n += 1
                end
            end
        end
        #Set the values in matrix
        if I ∉ HighFre
            out[I] = s/n
            A[I] = out[I]
        end
    end
end

function main()
    #  Load Image
    imagen = testimage("cameraman")
   
    # Image size
    n,m = size(imagen)
    # Create Predictor matrix space
    P = zeros(n,m)
    # blocks 8x8
    bloque = 8
    #Starst at 1, steps of 7 for rows
    for i in 1:bloque-1:n - bloque+1
        #col
        for j in 1:bloque-1:m - bloque+1
            predictor_aux = zeros(bloque,bloque) #temp matrix of 8x8
            #Gets the 8x8 square (starst at i, end up at 1+7 blocks for row and columns)
            @views aux = imagen[i : i + bloque-1, j : j + bloque-1]
            #Fill the predictor_aux with 1 row and 1 col
            predictor_aux[1, 1:end] = aux[1, 1:end]
            predictor_aux[1:end, 1] = aux[1:end, 1]
            
            #Get predictor 
            predictor(transpose(predictor_aux))
            P[i : (i + bloque-1, j) : j + bloque-1] = predictor_aux
        end
    end
   
    # Error matrix 
    E = imagen - P

    while true
        println("\n======================================")
        println("Ingresa el numero de bits a comprimir: ")
        n_bits = parse(Int, readline())

        n_muestras = 2^n_bits
        max_val = maximum(E)
        min_val = minimum(E)
        
        rg = (max_val - min_val) / n_muestras
        
        intervalo = collect(Float64(min_val):Float64(rg):Float64(max_val))

        #Quantification matrix
        Q = zeros(size(P))

        for j in CartesianIndices(E)
            for k in 1:length(intervalo)
                if E[j] == min_val
                    Q[j] = 1
                end
                if E[j] > intervalo[k]
                    Q[j] = k
                end
            end
        end
        #intervalo
        inversa = []
        for x in 1:length(intervalo)
            if x < length(intervalo)
                c = (intervalo[x] + intervalo[x+1])/ 2
                push!(inversa, c)  
            end
        end
        
        Q_inv = zeros(size(P))
        
        for j in CartesianIndices(Q)
            for k in 1:length(inversa) 
                if Q[j] == k
                    Q_inv[j] = inversa[k]
                end
            end
        end
        
        #Final matrix
        M_recup = Q_inv  + P
        
        k= mosaicview(imagen, P, E, M_recup; nrow=2)
        display(k)
        s_n = 10 * log10(sum(Float64.(imagen).^2) / sum((Float64.(imagen) - M_recup).^2))
        println("Signal/Noice : $s_n")

        println("\n########################################")
        println("Si deseas salir del programa ingresa 'q' o presiona cualquier tecla")
        op = readline()
        if op  == "q"
            break
        end
    end
end