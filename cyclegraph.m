function [A,L,V,D] = cyclegraph(dim)
%This function makes a cycle graph using the number of agents in the
%network. It returns the adjacency matrix, A, the Laplacian matrix, L, the
%eigenvectors, V, and the eigenvalues, D.

X = Nbots(dim);
I = X(:,6);
A = zeros(dim);

%% Initializing A, L, V, D
for j = 1:dim
       for i = 1:dim
             if I(j,1)+1 == I(i,1)
                 A(i,j)= 1;
             end
              
              if I(j,1)-1 == I(i,1)
                  A(i,j) = 1;
              end
              
              A(i,i) = 1;
        end
        
end

D_out = zeros(dim);

for i = 1:dim
    for j = 1:dim
        neighbor(j) = A(i,j);
    end
    diag(i) = sum(neighbor);
    D_out(i,i) = diag(i);
    neighbor = [];
end

L = D_out - A;
[V,D] = eig(L);

end