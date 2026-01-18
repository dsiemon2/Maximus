@extends('layouts.app')

@section('title', 'About Us')

@section('content')
<div class="container mt-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
            <li class="breadcrumb-item active">About Us</li>
        </ol>
    </nav>
</div>

<div class="container my-4">
    <div class="row">
        <div class="col-lg-8">
            <h1 style="color: var(--theme-primary);">About {{ config('app.name') }}</h1>

            <div class="card mb-4">
                <div class="card-body">
                    <h4>Our Story</h4>
                    <p>
                        Welcome to {{ config('app.name') }}, your trusted destination for premium pet food, supplies,
                        and accessories. We've been proudly serving pet parents with quality products that keep
                        their furry, feathered, and scaled companions happy and healthy.
                    </p>
                    <p>
                        Our commitment to quality, customer service, and pet wellness has made us a
                        favorite among pet owners who want only the best for their beloved animals.
                    </p>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-body">
                    <h4>Our Mission</h4>
                    <p>
                        At {{ config('app.name') }}, our mission is to provide pet parents with the finest selection of
                        pet supplies, combining quality products with exceptional customer service.
                        We believe every pet deserves the best care, and we're committed to helping you
                        provide a happy, healthy life for your beloved companions.
                    </p>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-body">
                    <h4>Why Choose Us?</h4>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="d-flex align-items-start">
                                <i class="bi bi-check-circle-fill text-success me-3 fs-4"></i>
                                <div>
                                    <h6>Quality Products</h6>
                                    <p class="text-muted mb-0">We carefully select each item to ensure quality and authenticity.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="d-flex align-items-start">
                                <i class="bi bi-check-circle-fill text-success me-3 fs-4"></i>
                                <div>
                                    <h6>Customer Service</h6>
                                    <p class="text-muted mb-0">Our team is dedicated to providing exceptional support.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="d-flex align-items-start">
                                <i class="bi bi-check-circle-fill text-success me-3 fs-4"></i>
                                <div>
                                    <h6>Fast Shipping</h6>
                                    <p class="text-muted mb-0">Quick and reliable delivery to your doorstep.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="d-flex align-items-start">
                                <i class="bi bi-check-circle-fill text-success me-3 fs-4"></i>
                                <div>
                                    <h6>Easy Returns</h6>
                                    <p class="text-muted mb-0">Hassle-free return policy for your peace of mind.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-geo-alt"></i> Visit Us</h5>
                </div>
                <div class="card-body">
                    <address>
                        <strong>{{ config('app.name') }}</strong><br>
                        456 Pet Boulevard<br>
                        Austin, TX 78701<br>
                        <i class="bi bi-telephone"></i> (555) 987-6543<br>
                        <i class="bi bi-envelope"></i> info@{{ str_replace(' ', '', strtolower(config('app.name'))) }}.com
                    </address>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-clock"></i> Store Hours</h5>
                </div>
                <div class="card-body">
                    <table class="table table-sm mb-0">
                        <tr>
                            <td>Monday - Friday</td>
                            <td>9:00 AM - 6:00 PM</td>
                        </tr>
                        <tr>
                            <td>Saturday</td>
                            <td>10:00 AM - 5:00 PM</td>
                        </tr>
                        <tr>
                            <td>Sunday</td>
                            <td>Closed</td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-question-circle"></i> Have Questions?</h5>
                </div>
                <div class="card-body">
                    <p class="mb-3">We're here to help! Reach out to our team.</p>
                    <a href="{{ route('contact') }}" class="btn btn-primary w-100">
                        <i class="bi bi-envelope"></i> Contact Us
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
