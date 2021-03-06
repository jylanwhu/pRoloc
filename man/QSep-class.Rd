\name{QSep-class}
\Rdversion{1.1}
\docType{class}
\alias{QSep-class}
\alias{class::QSep}
\alias{QSep}
\alias{show,QSep-method}
\alias{summary,QSep-method}
\alias{names,QSep-method}
\alias{names<-,QSep,character-method}
\alias{plot,QSep-method}
\alias{plot,QSep,missing-method}
\alias{levelPlot,QSep-method}
\alias{qsep}


\title{Quantify resolution of a spatial proteomics experiment}

\description{

  The \code{QSep} infrastructure provide a way to quantify the
  resolution of a spatial proteomics experiment, i.e. to quantify how
  well annotated sub-cellular clusters are separated from each other.

  The \code{QSep} function calculates all between and within cluster
  average distances. These distances are then divided column-wise by the
  respective within cluster average distance. For example, for a dataset
  with only 2 spatial clusters, we would obtain

  \tabular{ccc}{
    \tab  \eqn{c_1} \tab \eqn{c_2} \cr
    \eqn{c_1} \tab \eqn{d_11} \tab \eqn{d_12} \cr
    \eqn{c_2} \tab \eqn{d_21} \tab \eqn{d_22} 
  }
  
  Normalised distance represent the ratio of between to within average
  distances, i.e. how much bigger the average distance between cluster
  \eqn{c_i} and \eqn{c_j} is compared to the average distance within
  cluster \eqn{c_i}.

    \tabular{ccc}{
        \tab \eqn{c_1} \tab \eqn{c_2} \cr
    \eqn{c_1} \tab 1    \tab \eqn{\frac{d_12}{d_22}} \cr
    \eqn{c_2} \tab \eqn{\frac{d_21}{d_11}} \tab 1
  }

  Note that the normalised distance matrix is not symmetric anymore
  and the normalised distance ratios are proportional to the tightness
  of the reference cluster (along the columns).

}

\section{Objects from the Class}{

  Objects can be created by calls using the constructor
  \code{QSep} (see below).

}
\section{Slots}{
  \describe{

    \item{\code{x}:}{Object of class \code{"matrix"} containing the
      pairwise distance matrix, accessible with \code{qseq(., norm =
      FALSE)}. }

    \item{\code{xnorm}:}{Object of class \code{"matrix"} containing the
      normalised pairwise distance matrix, accessible with \code{qsep(.,
	norm = TRUE)} or \code{qsep(.)}. }
  
    \item{\code{object}:}{Object of class \code{"character"} with the
      variable name of \code{\linkS4class{MSnSet}} object that was used
      to generate the \code{QSep} object.}

    \item{\code{.__classVersion__}:}{Object of class \code{"Versions"}
      storing the class version of the object. }

  }
}

\section{Extends}{
  Class \code{"\linkS4class{Versioned}"}, directly.
}

\section{Methods and functions}{
  \describe{

    \item{QSeq}{\code{signature(object = "MSnSet", fcol = "character")}:
      constructor for \code{QSep} objects. The \code{fcol} argument
      defines the name of the feature variable that annotates the
      sub-cellular clusters. Non-marker proteins, that are marked as
      \code{"unknown"} are automatically removed prior to distance
      calculation. }

    \item{qsep}{\code{signature{object = "QSep", norm = "logical"}}:
      accessor for the normalised (when \code{norm} is \code{TRUE},
      which is default) and raw (when \code{norm} is \code{FALSE})
      pairwise distance matrices.}

    \item{names}{\code{signature{object = "QSep"}}: method to retrieve
      the names of the sub-celluar clusters originally defined in
      \code{QSep}'s \code{fcol} argument.  A replacement method
      \code{names(.) <- } is also available. }

    
    \item{summary}{\code{signature(object = "QSep", ..., verbose =
	"logical")}: Invisible return all between cluster average
      distances and prints (when \code{verbose} is \code{TRUE},
      default) a summary of those. }

    \item{levelPlot}{\code{signature(object = "QSep", norm = "logical",
	...)}: plots an annotated heatmap of all normalised pairwise
	distances. \code{norm} (default is \code{TRUE}) defines whether
	normalised distances should be plotted. Additional arguments
	\code{...} are passed to the \code{\link[lattice]{levelplot}}.
	}

    \item{plot}{\code{signature(object = "QSep", norm = "logical"...)}:
      produces a boxplot of all normalised pairwise distances. The red
      points represent the within average distance and black points
      between average distances. \code{norm} (default is \code{TRUE})
      defines whether normalised distances should be plotted.}

  }
  
}

%% \references{
%%   %%  TODO: add pre-print reference once posted on bioRXiv.
%% }

\author{
  Laurent Gatto <lg390@cam.ac.uk>
}

\examples{
## Test data from Christoforou et al. 2016
library("pRolocdata")
data(hyperLOPIT2015)

## Create the object and get a summary
hlq <- QSep(hyperLOPIT2015)
hlq
summary(hlq)

## mean distance matrix
qsep(hlq, norm = FALSE)

## normalised average distance matrix
qsep(hlq)

## Update the organelle cluster names for better
## rendering on the plots
names(hlq) <- sub("/", "\n", names(hlq))
names(hlq) <- sub(" - ", "\n", names(hlq))
names(hlq)

## Heatmap of the normalised intensities
levelPlot(hlq)

## Boxplot of the normalised intensities
par(mar = c(3, 10, 2, 1))
plot(hlq)

## Boxplot of all between cluster average distances
x <- summary(hlq, verbose = FALSE)
boxplot(x)

}

\keyword{classes}
