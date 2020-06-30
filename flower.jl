# Pkg.add("Plots")
# Pkg.add("PyPlot")
# ENV["PYTHON"]= "path to my local python.exe"
# Pkg.build("PyCall")

using Plots; pyplot();

n = 240;
Θ=range(-π/2,stop=π/2,length=n);
K = [5 7 9 11 13 15 17 19 21];
A = [1.0 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2];
C = ["lightcoral" "indianred1" "lightcoral" "coral" "indianred1" "firebrick1" "pink" "crimson" "firebrick1"];

Rhodonea = [A[f].*vcat([[cos(K[f]*θ)*cos(θ) cos(K[f]*θ)*sin(θ)] for θ=Θ]...) for f=1:size(K,2)];

draw = @animate for fr=1:(size(K,2)*n-1)
    f=Integer(floor(fr/n)+1);
    i=fr-n*(f-1);
    if f==1
        #only the first flower
        rhodonea=Rhodonea[1];
        plot(rhodonea[1:i,1],rhodonea[1:i,2],color=C[1],
            legend=false,xaxis=false,yaxis=false,
            xlims=(-1,1),ylims=(-1,1))
    else
        #the first one
        rhodonea=Rhodonea[1];
        plot(rhodonea[:,1],rhodonea[:,2],color=C[1],
            legend=false,xaxis=false,yaxis=false,
            xlims=(-1,1),ylims=(-1,1))
        #the others
        if f>2
            for f1=2:(f-1)
                rhodonea=Rhodonea[f1];
                plot!(rhodonea[:,1],rhodonea[:,2],color=C[f1])
            end
        end
        rhodonea=Rhodonea[f];
        plot!(rhodonea[1:i,1],rhodonea[1:i,2],color=C[f])
    end
end

gif(draw, "rhodonea.gif", fps = 48)
