defmodule Monte do

    @doc """
        a function round/5 that takes in the number of rounds k, the number of darts thrown this
        round j, the total number throw so far t, the radius of the circle r, and the accumulated
        darts inside the specified radius a.

    """
    def rounds(k, j, r) do
        rounds(k, j , 0, r, 0)
    end
    def rounds(0, _, t, _, a) do 4.0 * a/t end
    def rounds(k, j, t, r, a) do
        a = round(j, r, a)
        t = t + j
        j = j * 2           #modified to throw double the number of darts each round
        pi = 4.0 * a/t
        :io.format("\n ----- Calculated difference with 6 decimals -----\n")
        :io.format("\n Calculated pi = ~.6f Difference = (~.6f) \n ", [pi, (pi - :math.pi())])
        rounds(k-1, j, t, r , a)
    end
    @doc """
        a function round/3 that throws a number of darts, k, on a target with
        a radius of r and adding the hits to the accumulated value a.

    """
    
    def round(0, _, a) do a end
    def round(k, r, a) do
        if dart(r) do
        round(k-1, r, a+1)
        else
        round(k-1, r, a)	
        end
    end

    @doc """
        The general equation of a circle with radius R and origin (x0, y0) is

        ->          (x−x0)^2 + (y−y0)^2 = R^2

        If a point (x,y) is within the circle, you can interpret it as lying on circle with smaller
        radius r and the same origin. As r < R implies r^2 < R^2, which fulfills

        ->          (x−x0)^2 + (y−y0)^2 = r^2 < R^2

    """ 
    #checks if a dart lands inside a given radius using x and y as coordinates
    def dart(radius) do

        x = :rand.uniform(radius)
        y = :rand.uniform(radius)

        :math.pow(radius, 2) > :math.pow(x,2) + :math.pow(y,2)
    end
    
end