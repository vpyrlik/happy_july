#About Rhodonea Curves on Wiki:
#https://en.wikipedia.org/wiki/Rose_(mathematics)

# Pkg.add("Plots")
# Pkg.add("PyPlot")
# ENV["PYTHON"]= "path to my local python.exe"
# Pkg.build("PyCall")

using Plots; pyplot();

n = 240;
N = [2];
d = [5];
K = N./d;
A = [0.9];
C = ["indianred1"];

Rhodonea = [A[f].*vcat([[cos(K[f]*θ)*cos(θ) cos(K[f]*θ)*sin(θ)] for θ=range(-π/2/K[f],stop=-π/2/K[f]+2π*d[f],length=n)]...) for f=1:size(K,2)];

draw = @animate for fr=1:(size(K,2)*n-1)
    f=Integer(floor(fr/n)+1);
    i=fr-n*(f-1);
    if f==1
        #only the first flower
        rhodonea=Rhodonea[1];
        plot(rhodonea[1:i,1],rhodonea[1:i,2],color=C[1],
            legend=false,xaxis=false,yaxis=false,
            xlims=(-1,1),ylims=(-1,1),
            size=(400,400))
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
end;

gif(draw, "rhodonea.gif", fps = 24)
