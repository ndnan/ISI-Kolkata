function [ptsC, noise] = dbs(m, eps, mPts)
     
   [Npts, ~] = size(m);
   
    D = pdist2(m,m);
    
    Pvisit = zeros(Npts,1);  
    noise = zeros(Npts,1);
    ptsC  = zeros(Npts,1);
   
    Nc    = 0;                                  %Number of Clusters
    
    for n = 1 : Npts
        if ~Pvisit(n)                            
           Pvisit(n) = 1;                       
           Neighbors = findregion(n);          %Find Neighbours
           
           if numel(Neighbors) < mPts  
               noise(n) = 1;                    % Mark point n as noise.
           
           else                                 % Form a cluster...
               Nc = Nc + 1;    
               expand(n,Neighbors,Nc);
           end  
       end
    end
    Nc
    
    function expand(n,Neighbors,Nc)
               ptsC(n) = Nc;
               index = 1;       
               
               while true
                   nb = Neighbors(index);
                   
                   if ~Pvisit(nb)        
                       Pvisit(nb) = 1;  
    % Find the neighbours of this neighbour and if it has
    % enough neighbours add them to the neighbourPts list
          
            neighbourPtsP = findregion(nb);
                 if numel(neighbourPtsP) >= mPts
                      Neighbors = [Neighbors  neighbourPtsP];
                       end
                   end            
                   if ptsC(nb) == 0  
                       ptsC(nb) = Nc;
                   end
                   index = index + 1;  
                   if index > numel(Neighbors)
                   break;
                   end              
               end      
    end
    

function Neighbors=findregion(n)
        Neighbors=find(D(n,:)<=eps);
    end
end


