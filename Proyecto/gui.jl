using Images, ImageSegmentation, ImageView, Plots,Colors


function procesarImagen(img::Matrix, numberSeeds::Int)
    n,m = size(img)
    seeds = Tuple{CartesianIndex{2}, Int64}[]
    for i in 1:numberSeeds
        seed_g = CartesianIndex(rand(1:n),rand(1:m))
        push!(seeds, (seed_g,i))
    end
    segments = seeded_region_growing(img, seeds)
    img_sedeed = map(i->segment_mean(segments,i), labels_map(segments))

    clases = labels_map(segments)
    clases_mean_color = segment_mean(segments,)


    return img_sedeed,seeds,clases,clases_mean_color
end

function esVerde(tono::Tuple{Int8, Int8, Int8})
    r, g, b = tono
    umbral = 1
    if g > r && g > b && abs(g - r) > umbral && abs(g - b) > umbral
        return true
    else
        return false
    end
end


function main()
    img = load("C:/Users/Brandom/Documents/1Proyectopdi/montana.jpg")

    num_semillas = 300
    num_clases = 3

    img_sedeed, seeds1 = procesarImagen(img, num_semillas)
    img_sedeed_clasified, seeds2, labelMap, colorClases= procesarImagen(img_sedeed, num_clases)
    imshow(img)
    imshow(img_sedeed)

    #Inicializa diccionario (clase, cantidadPuntos)
    labels_dict = Dict{Int8, Int}()
    for i in 1:num_clases
        setindex!(labels_dict,0,i)
    end

    coordenadas = []
    for (cartesianC,_) in seeds1
        #plottin
        push!(coordenadas,(cartesianC[2],cartesianC[1]))
        #porcentaje de puntos en cada clase
        res_label = labelMap[cartesianC[1],cartesianC[2]]
        labels_dict[res_label] = labels_dict[res_label]+1
    end

    #porcentajes
    pointsClass1 = (labels_dict[1]/num_semillas)*100
    pointsClass2 = (labels_dict[2]/num_semillas)*100
    pointsClass3 = (labels_dict[3]/num_semillas)*100

    print(pointsClass1)
    print(pointsClass2)
    print(pointsClass3)
    print(" ")

    #Plot puntos e imagen
    tamano = 5 
    color = :red
    plot(img_sedeed_clasified)
    scatter!([p[1] for p in coordenadas], [p[2] for p in coordenadas], markersize = tamano, markercolor = color, legend = false)

    imshow(img_sedeed_clasified)

    
    for i in 1:num_clases
        colorDeClase=colorClases[i]*255
        tono = (Int(trunc(colorDeClase.r)),Int(trunc(colorDeClase.g)),Int(trunc(colorDeClase.b)))
        print(tono)
        
        print(esVerde(tono))
    end

    
end
