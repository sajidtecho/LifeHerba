<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Pharmacy Routes
|--------------------------------------------------------------------------
|
| Here is where you can register pharmacy routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('pharmacy')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Pharmacy module API endpoints.'
        ]);
    });
});
