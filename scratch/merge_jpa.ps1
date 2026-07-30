# Define mappings
$mappings = @(
    # JPA1
    @{ Branch = "jpa1/main"; Src = "src/main/java/org/example/jpa/controller/MainController.java"; Dest = "src/main/java/org/example/fatdogai2/jpa1/controller/MainController.java"; Type = "java"; Pkg = "jpa1" },
    @{ Branch = "jpa1/main"; Src = "src/main/java/org/example/jpa/dto/BookFormDTO.java"; Dest = "src/main/java/org/example/fatdogai2/jpa1/dto/BookFormDTO.java"; Type = "java"; Pkg = "jpa1" },
    @{ Branch = "jpa1/main"; Src = "src/main/java/org/example/jpa/entity/Book.java"; Dest = "src/main/java/org/example/fatdogai2/jpa1/entity/Book.java"; Type = "java"; Pkg = "jpa1" },
    @{ Branch = "jpa1/main"; Src = "src/main/java/org/example/jpa/repository/BookRepository.java"; Dest = "src/main/java/org/example/fatdogai2/jpa1/repository/BookRepository.java"; Type = "java"; Pkg = "jpa1" },
    @{ Branch = "jpa1/main"; Src = "src/main/java/org/example/jpa/service/BookService.java"; Dest = "src/main/java/org/example/fatdogai2/jpa1/service/BookService.java"; Type = "java"; Pkg = "jpa1" },
    @{ Branch = "jpa1/main"; Src = "src/main/webapp/WEB-INF/views/index.jsp"; Dest = "src/main/webapp/WEB-INF/views/jpa1/index.jsp"; Type = "jsp"; Pkg = "jpa1" },
    @{ Branch = "jpa1/main"; Src = "src/main/webapp/WEB-INF/views/detail.jsp"; Dest = "src/main/webapp/WEB-INF/views/jpa1/detail.jsp"; Type = "jsp"; Pkg = "jpa1" },

    # JPA2
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/controller/MainController.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/controller/MainController.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/controller/ReservationController.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/controller/ReservationController.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/dto/AnimalFormDTO.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/dto/AnimalFormDTO.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/dto/DoctorReservationDTO.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/dto/DoctorReservationDTO.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/dto/PetFormDTO.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/dto/PetFormDTO.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/dto/ReservationFormDTO.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/dto/ReservationFormDTO.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/entity/Animal.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/entity/Animal.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/entity/Doctor.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/entity/Doctor.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/entity/Pet.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/entity/Pet.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/entity/PetHistory.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/entity/PetHistory.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/entity/Reservation.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/entity/Reservation.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/repository/AnimalRepository.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/repository/AnimalRepository.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/repository/DoctorRepository.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/repository/DoctorRepository.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/repository/PetHistoryRepository.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/repository/PetHistoryRepository.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/repository/PetRepository.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/repository/PetRepository.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/repository/ReservationRepository.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/repository/ReservationRepository.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/service/PetService.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/service/PetService.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/java/org/example/jpa2/service/ReservationService.java"; Dest = "src/main/java/org/example/fatdogai2/jpa2/service/ReservationService.java"; Type = "java"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/webapp/WEB-INF/views/index.jsp"; Dest = "src/main/webapp/WEB-INF/views/jpa2/index.jsp"; Type = "jsp"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/webapp/WEB-INF/views/detail.jsp"; Dest = "src/main/webapp/WEB-INF/views/jpa2/detail.jsp"; Type = "jsp"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/webapp/WEB-INF/views/reservation.jsp"; Dest = "src/main/webapp/WEB-INF/views/jpa2/reservation.jsp"; Type = "jsp"; Pkg = "jpa2" },
    @{ Branch = "jpa2/main"; Src = "src/main/webapp/WEB-INF/views/n1.jsp"; Dest = "src/main/webapp/WEB-INF/views/jpa2/n1.jsp"; Type = "jsp"; Pkg = "jpa2" },

    # JPA3
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/config/JPAConfig.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/config/JPAConfig.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/controller/MainController.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/controller/MainController.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/dto/PhoneFormDTO.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/dto/PhoneFormDTO.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/entity/BaseEntity.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/entity/BaseEntity.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/entity/Phone.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/entity/Phone.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/repository/JPAPhoneRepository.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/repository/JPAPhoneRepository.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/repository/PhoneRepository.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/repository/PhoneRepository.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/repository/PhoneRepositoryImpl.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/repository/PhoneRepositoryImpl.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/service/PhoneService.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/service/PhoneService.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/java/org/example/jpa3/service/PhoneService2.java"; Dest = "src/main/java/org/example/fatdogai2/jpa3/service/PhoneService2.java"; Type = "java"; Pkg = "jpa3" },
    @{ Branch = "jpa3/main"; Src = "src/main/webapp/WEB-INF/views/index.jsp"; Dest = "src/main/webapp/WEB-INF/views/jpa3/index.jsp"; Type = "jsp"; Pkg = "jpa3" }
)

$tempFile = "C:\workspace\FatDogAi2\scratch\temp_git_show.txt"

# Ensure scratch directory exists
if (-not (Test-Path "C:\workspace\FatDogAi2\scratch")) {
    New-Item -ItemType Directory -Path "C:\workspace\FatDogAi2\scratch" -Force
}

foreach ($item in $mappings) {
    Write-Host "Processing $($item.Src) -> $($item.Dest)"
    
    # 1. Fetch file using cmd redirect to preserve raw UTF-8 bytes
    cmd /c "git show $($item.Branch):$($item.Src) > `"$tempFile`""
    
    # Read it into memory as raw UTF-8 string
    $content = [System.IO.File]::ReadAllText($tempFile, [System.Text.Encoding]::UTF8)

    # 2. Perform package and import replacements for Java files
    if ($item.Type -eq "java") {
        $content = $content -replace 'org\.example\.jpa\b', 'org.example.fatdogai2.jpa1'
        $content = $content -replace 'org\.example\.jpa2\b', 'org.example.fatdogai2.jpa2'
        $content = $content -replace 'org\.example\.jpa3\b', 'org.example.fatdogai2.jpa3'

        # Controller path adjustments to prevent conflicts
        if ($item.Src -eq "src/main/java/org/example/jpa/controller/MainController.java") {
            $content = $content -replace '@Controller\b', '@Controller("jpa1MainController")'
            $content = $content -replace '@RequestMapping', '@RequestMapping("/jpa1")'
            $content = $content -replace '"index"', '"jpa1/index"'
            $content = $content -replace '"detail"', '"jpa1/detail"'
            $content = $content -replace '"redirect:/"', '"redirect:/jpa1"'
        }
        if ($item.Src -eq "src/main/java/org/example/jpa2/controller/MainController.java") {
            $content = $content -replace '@Controller\b', '@Controller("jpa2MainController")'
            $content = $content -replace '@RequestMapping', '@RequestMapping("/jpa2")'
            $content = $content -replace '"index"', '"jpa2/index"'
            $content = $content -replace '"detail"', '"jpa2/detail"'
            $content = $content -replace '"redirect:/"', '"redirect:/jpa2"'
        }
        if ($item.Src -eq "src/main/java/org/example/jpa2/controller/ReservationController.java") {
            $content = $content -replace '@RequestMapping\("/reservation"\)', '@RequestMapping("/jpa2/reservation")'
            $content = $content -replace '"reservation"', '"jpa2/reservation"'
            $content = $content -replace '"n1"', '"jpa2/n1"'
            $content = $content -replace '"redirect:/reservation"', '"redirect:/jpa2/reservation"'
        }
        if ($item.Src -eq "src/main/java/org/example/jpa3/controller/MainController.java") {
            $content = $content -replace '@Controller\b', '@Controller("jpa3MainController")'
            $content = $content -replace '@RequestMapping', '@RequestMapping("/jpa3")'
            $content = $content -replace '"index"', '"jpa3/index"'
            $content = $content -replace '"redirect:/"', '"redirect:/jpa3"'
        }
    }

    # 3. Perform link/form replacements for JSP files
    if ($item.Type -eq "jsp") {
        if ($item.Pkg -eq "jpa1") {
            $content = $content -replace 'href="/\$\{book\.id\}"', 'href="/jpa1/${book.id}"'
            $content = $content -replace 'action="/\$\{book\.id\}"', 'action="/jpa1/${book.id}"'
            $content = $content -replace 'href="/delete/\$\{book\.id\}"', 'href="/jpa1/delete/${book.id}"'
            $content = $content -replace 'href="/"', 'href="/jpa1"'
        }
        if ($item.Pkg -eq "jpa2") {
            $content = $content -replace 'action="/animal"', 'action="/jpa2/animal"'
            $content = $content -replace 'href="/\$\{pet\.id\}"', 'href="/jpa2/${pet.id}"'
            $content = $content -replace 'href="/\$\{pet\.id\}/delete"', 'href="/jpa2/${pet.id}/delete"'
            $content = $content -replace 'href="/"', 'href="/jpa2"'
            $content = $content -replace 'action="/reservation/doctor"', 'action="/jpa2/reservation/doctor"'
        }
        if ($item.Pkg -eq "jpa3") {
            $content = $content -replace 'action="/\$\{phone\.id\}/name"', 'action="/jpa3/${phone.id}/name"'
            $content = $content -replace 'action="/list"', 'action="/jpa3/list"'
        }
    }

    # Ensure destination directory exists
    $destFile = New-Item -Path $item.Dest -Force
    $destPath = $destFile.FullName
    
    # Save content without BOM
    $utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($destPath, $content, $utf8WithoutBom)
}

# Clean up temp file
if (Test-Path $tempFile) {
    Remove-Item $tempFile
}

Write-Host "Merge script execution completed!"
